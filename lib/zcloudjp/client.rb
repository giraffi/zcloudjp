# encoding: utf-8
require 'ostruct'
require 'httparty'
require 'active_support/core_ext'

module Zcloudjp
  class Client
    include HTTParty
    format :json

    def initialize(options={})
      @api_key  = options.delete(:api_key) || ENV['ZCLOUDJP_API_KEY']
      @base_uri = options[:endpoint] || "https://my.z-cloud.jp"
      unless @api_key; raise ArgumentError, "options[:api_key] required"; end
      request_options
    end

    def request_options
      @request_options = {
        :base_uri => @base_uri,
        :headers  => {
          "X-API-KEY"    =>  @api_key,
          "Content-Type" => "application/json; charset=utf-8",
          "Accept"       => "application/json",
          "User-Agent"   =>  Zcloudjp::USER_AGENT
         }
      }
    end

    # Defines the method if not defined yet.
    def method_missing(method, *args, &block)
      self.class.class_eval do
        attr_accessor method.to_sym

        # Defined a method according to the given method name
        define_method method.to_sym do
          obj = OpenStruct.new(request_options: @request_options)
          obj.extend Zcloudjp.const_get(method.capitalize.to_sym)
          instance_variable_set(:"@#{method}", obj)
        end
      end

      # Sends to the now-defined method.
      self.__send__(method.to_sym)
    end
  end
end
