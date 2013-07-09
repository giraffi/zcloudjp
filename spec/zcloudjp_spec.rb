# encoding: utf-8
require 'spec_helper'

describe Zcloudjp do
  describe ".new"  do
    it "creates a client" do
      client = Zcloud.new(:api_key => 'abc')
      expect(client).to be_a Zcloud::Client
    end

    it "raises an ArgumentError when the API key is not specified" do
      expect{Zcloud.new}.to raise_error ArgumentError
    end
  end
end
