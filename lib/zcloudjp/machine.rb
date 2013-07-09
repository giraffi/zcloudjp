# encoding: utf-8

module Zcloudjp
  module Machine

    # GET /machines.json
    def index(params={})
      self.request_options = self.request_options.merge(params[:query] || {})
      response = Zcloudjp::Client.get("/machines", self.request_options)
      response.parsed_response.map do |res|
        update_attributes(res).clone
      end
    end
    alias :list :index

    # GET /machines/:id.json
    def show(params={})
      id = params.delete(:id) || self.id
      response = Zcloudjp::Client.get("/machines/#{id}", self.request_options)
      update_attributes(response.parsed_response)
    end
    alias :find_by :show

    # POST /machines.:format
    def create(params={})
      self.request_options = self.request_options.merge(body: params.to_json)
      response = Zcloudjp::Client.post("/machines", self.request_options)
      update_attributes(response.parsed_response)
    end

    # DELETE /machines/:id.:format
    def delete(params={})
      id = params.delete(:id) || self.id
      response = Zcloudjp::Client.delete("/machines/#{id}", self.request_options)
      update_attributes(response.parsed_response)
    end

    # Create a Metadata object related to the specified machine
    def metadata
      Metadata.new(self)
    end

  protected

    def update_attributes(response)
      response = response.first if response.is_a? Array
      response.each do |key, value|
        self.instance_variable_set(:"@#{key}", value)
        self.send("#{key}=", value)
      end
      self
    end
  end
end
