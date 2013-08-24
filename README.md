## Demo Usage

* set hosts: `127.0.0.1 dev.session.com dev.app1.com dev.app2.com`
* `bundle install`
* `foreman start`
* `open http://dev.app1.com`
* set session data to app1: `open http://dev.app1.com:4567?name=hooopo`
* read session data from remote: `open http://dev.app2.com:4568`
