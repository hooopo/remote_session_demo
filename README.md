## Demo Usage

* set hosts: `127.0.0.1 dev.session.com dev.app1.com dev.app2.com`
* `bundle install`
* `rackup`
* `ruby app.rb -p 4567` as app 1
* `ruby app.rb -p 4568` as app 2
* `open http://dev.app1.com`
* set session data to app1: `open http://dev.app1.com:4567?name=hooopo`
* read session data from remote: `open http://dev.app2.com:4568`
