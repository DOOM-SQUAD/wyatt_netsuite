require 'spec_helper'

describe Wyatt::Netsuite::Request do

  let(:request)                { Wyatt::Netsuite::Request }
  let(:config)                 { Wyatt::Netsuite::Configuration }

  let(:initialize_path)        { config.initialize_path }
  let(:load_path)              { config.load_path }
  let(:upsert_path)            { config.upsert_path }

  let(:body)                   { {'test' => 'test' } }
  let(:build_params)           { true }

  before do
    config.stub(:initialize_path) { 'initialize string' }
    config.stub(:load_path)       { 'load string' }
    config.stub(:upsert_path)     { 'upsert string' }
  end

  describe ".netsuite_initialize" do
    it 'initializes a request for an initialize operation' do
      request.should_receive(:new).with(:post, initialize_path, build_params, body)
      request.netsuite_initialize(body)
    end
  end

  describe "#load" do
    it "initializes a request for a load operation" do
      request.should_receive(:new).with(:post, load_path, build_params, body)
      request.load(body)
    end
  end

  describe "#upsert" do
     it "initializes a request for an upsert operation" do
      request.should_receive(:new).with(:post, upsert_path, build_params, body)
      request.upsert(body)
    end
  end

  describe "#transform" do
  end

  describe "#delete" do
  end

  describe "#search" do
  end

  describe "#saved_search" do
  end
end
