# encoding: utf-8
require 'spec_helper'

describe Zcloudjp do
  describe ".new"  do
    it "creates a client" do
      client = Zcloudjp.new(:api_key => 'abc')
      expect(client).to be_a Zcloudjp::Client
    end

    it "raises an ArgumentError when the API key is not specified" do
      expect{ Zcloudjp.new }.to raise_error ArgumentError
    end
  end
end
