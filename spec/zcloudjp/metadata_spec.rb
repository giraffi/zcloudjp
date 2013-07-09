# encoding: utf-8
require 'spec_helper'

describe Zcloudjp::Metadata do
  before do
    @client = Zcloudjp.new(
      api_key: "abc",
      base_uri: "https://my.z-cloud.jp"
    )
    stub_get(@client.base_uri, "/machines/1").
      to_return(:status => 200, :body => fixture("machine.json"), :headers => {:content_type => "application/json; charset=utf-8"})
  end

  describe "#index" do
    before do
      stub_get(@client.base_uri, "/machines/1/metadata").
        to_return(:status => 200, :body => fixture("metadata.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "returns true when having the user-script key" do
      machine = @client.machine.find_by id: "1"
      metadata = machine.metadata.list
      expect(metadata.parsed_response["metadata"].has_key?("user-script")).to be_true
    end

    it "returns true when having the user-data key" do
      machine = @client.machine.find_by id: "1"
      metadata = machine.metadata.list
      expect(metadata.parsed_response["metadata"].has_key?("user-data")).to be_true
    end
  end

  describe "#show" do
    before do
      stub_get(@client.base_uri, "/machines/1/metadata/user-data").
        to_return(:status => 200, :body => fixture("metadata_user-data.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "returns true when having a value for the user-script key" do
      machine = @client.machine.find_by id: "1"
      metadata = machine.metadata.find_by key: "user-data"
      expect(metadata.parsed_response["value"]).to match(/foo@example\.com/)
    end

    it "returns true when Hash has a value for user-data key" do
      machine = @client.machine.find_by id: "1"
      metadata = machine.metadata.find_by key: "user-data"
      expect(metadata.parsed_response["value"]).to match(/foo@example\.com/)
    end
  end

  describe "#create" do
    before do
      stub_put(@client.base_uri, "/machines/1/metadata/user-name").
        with(:body => MultiJson.load(fixture("add_a_key_into_metadata.json"))).
        to_return(:status => 200, :body => fixture("metadata.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    context "params given by Hash object" do
      before do
        machine = @client.machine.find_by id: "1"
        @metadata = machine.metadata.create(
          MultiJson.load(fixture('add_a_key_into_metadata.json'), symbolize_keys: true).merge!(key: 'user-name')
        )
      end

      it "returns true when having a value for the user-script key" do
        expect(@metadata.parsed_response["metadata"]["user-script"]).to match(/if command/)
      end

      it "returns true when having a value for the user-data key" do
        expect(@metadata.parsed_response["metadata"]["user-data"]).to match(/foo@examle\.com/)
      end

      it "returns true when having a value for the user-name key" do
        expect(@metadata.parsed_response["metadata"]["user-name"]).to match(/foo/)
      end
    end
  end

  describe "#update" do
    before do
      stub_put(@client.base_uri, "/machines/1/metadata").
        with(:body => MultiJson.load(fixture("update_a_key_of_metadata.json"))).
        to_return(:status => 200, :body => fixture("updated_metadata.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    context "params given by Hash object" do
      before do
        machine = @client.machine.find_by id: "1"
        @metadata = machine.metadata.update({"user-name"=>"awesome"})
      end

      it "returns true when having value for the user-script key" do
        expect(@metadata.parsed_response["metadata"]["user-name"]).to match(/awesome/)
      end
    end
  end

  describe "#delete" do
    before do
      stub_delete(@client.base_uri, "/machines/1/metadata/user-data").
        to_return(:status => 200, :body => fixture("delete_metadata.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "returns true when a specified metadata is deleted" do
      machine = @client.machine.find_by id: "1"
      @metadata = machine.metadata.delete(key: 'user-data')
      expect(@metadata.parsed_response).to eq MultiJson.load(fixture('delete_metadata.json'))
    end
  end
end
