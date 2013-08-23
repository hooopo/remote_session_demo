require 'sinatra/base'
require 'pry'
require 'redis'
require 'hiredis'
require 'json'
require 'securerandom'
$redis = Redis.new(:driver => :hiredis)

class SessionServer < Sinatra::Base
  set :logging, true
  set :sessions, false

  get "/" do
    binding.pry
    "OK"
  end

  get "/generate_session_id" do
    if session_id = request.env["HTTP_IF_NONE_MATCH"]
      headers["Etag"] = session_id
    else
      headers["Etag"] = SecureRandom.hex
    end
    "#{params[:callback]}(#{{:session_id => headers["Etag"]}.to_json})"
  end

  get "/session/:session_id" do
    $redis.get(params[:session_id])
  end

  put "/session/:session_id" do
    env["rack.input"].rewind
    body = env["rack.input"].read
    $redis.set(params[:session_id], body)
    "OK"
  end
end
