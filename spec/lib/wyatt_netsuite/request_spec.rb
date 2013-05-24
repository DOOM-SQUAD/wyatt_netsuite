require 'spec_helper'

describe Wyatt::Netsuite::Request do

  let(:request)                { Wyatt::Netsuite::Request }
  let(:config)                 { Wyatt::Netsuite::Configuration }
  let(:initialize_path)        { config.initialize_path }
  let(:load_path)              { config.load_path }
  let(:body)                   { {'test' => 'test' } }
  let(:build_params)           { true }
  let(:initialize_path_string) { 'initialize string' }
  let(:load_path_string)       { 'load string' }

  before do
    config.stub(:initialize_path) { initialize_path_string }
    config.stub(:load_path)       { load_path_string }
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
  end

  describe "#transform" do
  end

  describe "#delete" do
  end

  describe "#upsert" do
  end

  describe "#search" do
  end

  describe "#saved_search" do
  end
end
