# Webmachine for Ruby Example

This is a very simple example of using [webmachine for Ruby](https://github.com/webmachine/webmachine-ruby).

It is used as the example code in my article [What Has Erlang Ever Done For Me? Part II - Web Services & Webmachine](http://www.catalystcomputing.co.uk/rob-westwood/2016/11/programming/what-has-erlang-ever-done-for-me-part-ii-webmachine/), part of a [series of posts](http://www.catalystcomputing.co.uk/rob-westwood/2016/11/programming/what-has-erlang-ever-done-for-me-part-i-introduction/) about ideas from the Erlang community that I have found useful. In this case it is looking at an alternative paradigm for implementing Web services.

The series of commits represent the stages of building the example in the article.

## Prerequistes

You will need a working installation of Ruby 2.2 or later, and curl to run the examples.

## Running the Example

1. Install the gems. This will install them to their local directory; if you would like them installed to system ron't include the `--path=vendor/local` argument.

```sh
$ bundle install --path=vendor/local
```

2. Run the web service.

```sh
$ bundle exec ./my_webservice.rb
```

3. Sample requests (expected comments are shown as comments below each command; the `$` is just the shell prompt).

Straightforward web request.
```sh
$ curl -isL http://localhost:8008/people/rob
# HTTP/1.1 200 OK 
# Content-Type: text/html
# Vary: Accept
# Content-Length: 50
# Date: Tue, 22 Nov 2016 12:46:41 GMT
# Server: Webmachine-Ruby/1.4.0 WEBrick/1.3.1 (Ruby/2.3.1/2016-04-26)
# Connection: Keep-Alive
# 
# <html><head></head><body>Hello, rob!</body></html>
```

Request a non-existent resource.
```sh
$ curl -IsL http://localhost:8008/people/fred
# HTTP/1.1 404 Not Found 
# Content-Type: text/html
# Vary: Accept
# Content-Length: 219
# Date: Tue, 22 Nov 2016 12:48:13 GMT
# Server: Webmachine-Ruby/1.4.0 WEBrick/1.3.1 (Ruby/2.3.1/2016-04-26)
# Connection: Keep-Alive
```

Request a different content type via a `Accept:` header.
```sh
$ curl -isL -H "Accept: application/xml" http://localhost:8008/people/rob
# HTTP/1.1 200 OK 
# Content-Type: application/xml
# Vary: Accept
# Content-Length: 77
# Date: Tue, 22 Nov 2016 12:50:12 GMT
# Server: Webmachine-Ruby/1.4.0 WEBrick/1.3.1 (Ruby/2.3.1/2016-04-26)
# Connection: Keep-Alive
# 
# <?xml version="1.0" encoding="UTF-8"?>
# <person>
#   <name>rob</name>
# </person>
```

Requesting an unsupported content type responses with a HTTP 406 code.
```sh
$ curl -IsL -H "Accept: text/plain" http://localhost:8008/people/rob
# HTTP/1.1 406 Not Acceptable 
# Content-Length: 0
# Date: Tue, 22 Nov 2016 12:51:31 GMT
# Server: Webmachine-Ruby/1.4.0 WEBrick/1.3.1 (Ruby/2.3.1/2016-04-26)
# Connection: Keep-Alive

```


