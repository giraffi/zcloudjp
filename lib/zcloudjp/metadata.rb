# encoding: utf-8
require 'zcloudjp/utils'

module Zcloudjp
  module Metadata
    include Utils

    attr_reader :machine

    # TODO
    # Should be hybrid: executable when a machine object is given or not.

    def initialize(machine)
      @machine = machine
    end

    # GET /machines/:id/metadata.:format
    def index
      Zcloudjp::Client.get("/machines/#{machine.id}/metadata", machine.request_options)
    end

    # GET /machines/:id/metadata/:key.:format
    def show(params={})
      key = params.delete(:key)
      Zcloudjp::Client.get("/machines/#{machine.id}/metadata/#{key}", machine.request_options)
    end

    # PUT /machines/:id/metadata.:format
    def create(params={})
      key = params.delete(:key)
      machine.request_options = machine.request_options.merge(body: parse_params(params, :value).to_json)
      Zcloudjp::Client.put("/machines/#{machine.id}/metadata/#{key}", machine.request_options)
    end

    # PUT /machines/:id/metadata/:key.:format
    def update(params={})
      machine.request_options = machine.request_options.merge(body: parse_params(params, :metadata).to_json)
      Zcloudjp::Client.put("/machines/#{machine.id}/metadata", machine.request_options)
    end

    # DELETE /machines/:id/metadata/:key.:format
    def delete(params={})
      key = params.delete(:key)
      Zcloudjp::Client.delete("/machines/#{machine.id}/metadata/#{key}", machine.request_options)
    end
  end
end
