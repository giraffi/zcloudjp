# encoding: utf-8
require 'spec_helper'

describe Zcloudjp::Machine do
  before do
    @client = Zcloudjp.new(
      api_key: "abc",
      base_uri: "https://my.z-cloud.jp"
    )
    @machine_methods = Zcloudjp::Machine.public_instance_methods
  end

  describe "#index" do
    before do
      stub_get(@client.base_uri, "/machines").to_return(
        :status => 200, :body => fixture("machines.json"), :headers => { :content_type => "application/json; charset=utf-8" }
      )
    end

    it "returns an array having 2 object" do
      machines = @client.machine.list
      expect(machines.size).to eql 2
    end

    it "returns an open_struct object" do
      machines = @client.machine.list
      expect(machines.first).to be_a OpenStruct
    end

    it "returns true when the object is extended" do
      machines = @client.machine.list
      @machine_methods.each { |method| expect(machines.first).to respond_to method }
    end
  end

  describe "#show" do
    before do
      stub_get(@client.base_uri, "/machines/1").to_return(
        :status => 200, :body => fixture("machine.json"), :headers => {:content_type => "application/json; charset=utf-8"}
      )
    end

    it "returns an open_struct object" do
      machine = @client.machine.find_by id: '1'
      expect(machine).to be_a OpenStruct
    end

    it "returns an id that is equal to the given id" do
      machine = @client.machine.find_by id: '1'
      expect(machine.id).to eq '1'
    end

    it "returns true when the object is extended" do
      machine = @client.machine.find_by id: '1'
      @machine_methods.each do |method|
        expect(machine).to respond_to method
      end
    end
  end

  describe "#create" do
    before do
      stub_post(@client.base_uri, "/machines").with(:body => fixture('machine_with_metadata.json').read.chomp).to_return(
        :status => 201, :body => fixture("machine.json"), :headers => {:content_type => "application/json; charset=utf-8"}
      )
    end

    it "returns true when the machine name is equal to the given name" do
      machine = @client.machine.create(MultiJson.load(fixture('machine_with_metadata.json'), symbolize_keys: true))
      expect(machine.name).to eq "my_smart_machine"
    end

    it "returns true when the object is extended" do
      machine = @client.machine.create(MultiJson.load(fixture('machine_with_metadata.json'), symbolize_keys: true))
      @machine_methods.each do |method|
        expect(machine).to respond_to method
      end
    end
  end

  describe "#delete" do
    before do
      stub_delete(@client.base_uri, "/machines/1").
        to_return(:status => 200, :body => fixture("machine.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "returns OpenStruct with machine attributes" do
      machine = @client.machine.delete(id: '1')
      expect(machine).to be_a OpenStruct
    end

    it "returns an id that is equal to the given id" do
      machine = @client.machine.delete(id: '1')
      expect(machine.id).to eql '1'
    end

    it "returns true if the methods are extended" do
      machine = @client.machine.delete(id: '1')
      @machine_methods.each do |method|
        expect(machine).to respond_to method
      end
    end
  end
end
