# encoding: uf-8
require 'zcloudjp/version'
require 'zcloudjp/clinet'
require 'zcloudjp/machine'
require 'Zcloudjp/utils'

module Zcloudjp
  USER_AGENT = "zcloudjp-gem/#{Zcloudjp::VERSION} (#{RUBY_PLATFORM}) ruby/#{RUBY_VERSION}"

  class << self
    def new(options)
      @client = Zcloudjp::Client.new(options)
      @client
    end

    def user_agent
      @@user_agent ||= USER_AGENT
    end

    def user_agent=(agent)
      @@user_agent = agent
    end
  end
end

