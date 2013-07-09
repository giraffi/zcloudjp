unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'spec'
  end
end

require 'zcloud'
require 'rspec'
require 'multi_json'
require 'webmock/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def stub_delete(endpoint, path)
  stub_request(:delete, endpoint + path)
end

def stub_get(endpoint, path)
  stub_request(:get, endpoint + path)
end

def stub_post(endpoint, path)
  stub_request(:post, endpoint + path)
end

def stub_put(endpoint, path)
  stub_request(:put, endpoint + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
