require 'sinatra'
require 'json'
require 'pry'
require 'httparty'

before do
  $html ||= DATA.read
end

get "/" do
  html = $html.sub("__cookies__", request.cookies.to_json)
  if remote_session_id = request.cookies["remote_session_id"]
    HTTParty.put("http://dev.session.com:9292/session/#{remote_session_id}", :body => params.to_json) unless params.empty?
    html.sub!("__remote_session_data__", HTTParty.get("http://dev.session.com:9292/session/#{remote_session_id}").body)
  else
    html.sub!("__remote_session_data__", "")
  end
  html
end

__END__
<head>
  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
  <script type="text/javascript">
    //<![CDATA[
      $.ajax({
      url: 'http://dev.session.com:9292/generate_session_id?callback=set_session_id',
      dataType: "script",
      cache: true
    });

    function set_session_id(result){
      document.cookie = "remote_session_id=" + result.session_id;
    }

    //]]>
  </script>
</head>
<body>
  <h1>Cookies</h1>
  <pre>__cookies__</pre>
  <h1>RemoteSessionData</h1>
  <pre>__remote_session_data__</pre>
</body>

