## Demo Usage

* set hosts: `127.0.0.1 dev.session.com dev.app1.com dev.app2.com`
* `bundle install`
* `foreman start`
* set session data in app1: `open http://dev.app1.com:4567?name=hooopo`
* read session data from remote in app2: `open http://dev.app2.com:4568`
