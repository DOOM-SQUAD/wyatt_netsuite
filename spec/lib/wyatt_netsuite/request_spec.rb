require 'spec_helper'

describe Wyatt::Netsuite::Request do

  let(:request)                { Wyatt::Netsuite::Request }
  let(:config)                 { Wyatt::Netsuite::Configuration }

  let(:initialize_path)        { config.initialize_path }
  let(:load_path)              { config.load_path }
  let(:upsert_path)            { config.upsert_path }
  let(:transform_path)         { config.transform_path }
  let(:delete_path)            { config.delete_path }
  let(:search_path)            { config.search_path }
  let(:saved_search_path)      { config.saved_search_path }

  let(:body)                   { {'test' => 'test' } }
  let(:build_params)           { true }

  before do
    config.stub(:initialize_path)   { 'initialize string' }
    config.stub(:load_path)         { 'load string' }
    config.stub(:upsert_path)       { 'upsert string' }
    config.stub(:transform_path)    { 'transform string' }
    config.stub(:delete_path)       { 'delete string' }
    config.stub(:search_path)       { 'search string' }
    config.stub(:saved_search_path) { 'saved_search string' }
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
    it "initializes a request for a transform operation" do
      request.should_receive(:new).with(:post, transform_path, build_params, body)
      request.transform(body)
    end
  end

  describe "#delete" do
    it "initializes a request for a delete operation" do
      request.should_receive(:new).with(:post, delete_path, build_params, body)
      request.delete(body)
    end
  end

  describe "#search" do
    it "initializes a request for a search operation" do
      request.should_receive(:new).with(:post, search_path, build_params, body)
      request.search(body)
    end
  end

  describe "#saved_search" do
    it "initializes a request for a saved_search operation" do
      request.should_receive(:new).with(:post, saved_search_path, build_params, body)
      request.saved_search(body)
    end
  end

end
