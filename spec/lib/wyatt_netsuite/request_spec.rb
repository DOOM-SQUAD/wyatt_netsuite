require 'spec_helper'

describe Wyatt::Netsuite::Request do

  let(:request) { Wyatt::Netsuite::Request }
  let(:body) { {'test' => 'test' } }
  let(:initialize_path) { Wyatt::Netsuite::Configuration.initialize_path }
  let(:build_params) { true }
  let(:initialize_path_string) { 'string' }

  before do
    Wyatt::Netsuite::Configuration.stub(:initialize_path) { initialize_path_string }
  end

  describe ".netsuite_initialize" do
    it 'initializes a netsuite flavored faraday request' do
      request.should_receive(:new).with(:post, initialize_path, build_params, body)
      request.netsuite_initialize(body)
    end
  end

  describe "#load" do
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
