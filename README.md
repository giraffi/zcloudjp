# Zcloudjp
[![Build Status](https://travis-ci.org/giraffi/zcloudjp.png?branch=master)](https://travis-ci.org/giraffi/zcloudjp)  
A Ruby interface to the [Z Cloud](http://z-cloud.jp/) API.

## Installation

Add this line to your application's Gemfile:

    gem 'zcloudjp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zcloudjp

## Usage

```
$ export ZCLOUDJP_API_KEY=abc
$ pry
> require 'zcloudjp'
=> true
> @client = Zcloudjp.new
.. snip ..
> @machine = @client.machine.create(dataset: "sdc:sdc:base64:13.1.0", package: "Small_1GB")
=> #<OpenStruct request_options={:base_uri=>"https://my.z-cloud.jp", :headers=>{"X-API-KEY"=>"abc", "Content-Type"=>"application/json; charset=utf-8", "Accept"=>"application/json", "User-Agent"=>"zcloudjp-gem/0.1.0 (x86_64-darwin11.4.2) ruby/1.9.3"}, :body=>"{\"dataset\":\"sdc:sdc:base64:13.1.0\",\"package\":\"Small_1GB\"}"}, id="9796d336-f249-440f-a440-454fab97d602", name=nil, type="smartmachine", state="provisioning", dataset="sdc:sdc:base64:13.1.0", memory=1024, disk=30720, ips=["192.168.137.196"], metadata={}, created="2013-07-09T06:08:46+00:00", updated="2013-07-09T06:08:47+00:00", account_id=723, os="SmartOS", kind="SmartOS", package="Small_1GB", subdomain=nil, alert=nil>
> @machine.metadata.list
=> {"metadata"=> {}}
> @machine.metadata.create(nick: 'fuubar')
=> {"metadata"=> {
        "nick"=>"fuubar"}}
> @machine.state
=> "running"
> @machine.stop
> @machine.reload.state
=> "stopped"
> @machine.delete
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
