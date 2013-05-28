require 'spec_helper'

describe Wyatt::Netsuite::Response do

  let(:response)             { Wyatt::Netsuite::Response.new(faraday_response) }
  let(:bad_response)         { Wyatt::Netsuite::Response.new(bad_faraday_response) }

  let(:exception)            { Wyatt::Netsuite::Exception::NetsuiteException }

  let(:faraday_body)         { { result: [{}, {}] } } 
  let(:faraday_response)     { mock(body: faraday_body, status: 200) }

  let(:bad_faraday_body)     { { exception: { trace: 'trace', message: 'message' } } }
  let(:bad_faraday_response) { mock(body: bad_faraday_body, status: 200) }

  let(:result1)              { mock(success?: true) }
  let(:result2)              { mock(success?: false) }
  let(:result3)              { mock(success?: true) }

  let(:result_list)          { [result1, result2, result3] }
  let(:successful_results)   { [result1, result3] }
  let(:failed_results)       { [result2] }

  before do
    Wyatt::Netsuite::Response.any_instance.stub(:build_results) { result_list }
  end

  describe "#initialize" do

    describe 'no exception has occured' do

      before do
        Wyatt::Netsuite::Response.any_instance.stub(:handle_exception)
      end

      it 'should initialize the faraday_response' do
        response.faraday_response.should eq(faraday_response)
      end

      it 'should initialize the list of results' do
        response.results.should eq( result_list )
      end

    end

    describe 'an exception occurs in NetSuite' do


      before do
        Wyatt::Netsuite::Response.any_instance.stub(:success?) { false }
      end

      it 'should raise a NetsuiteException exception' do
        expect { bad_response }.to raise_error(exception)
      end

    end

  end

  describe '#success?' do

    let(:success_status) { response.success? }

    before do
      Wyatt::Netsuite::Response.any_instance.stub(:handle_exception)
    end

    describe 'a successful response' do

      before do
        response.stub(:body) { faraday_body }
      end

      it 'should return true' do
        success_status.should eq( true )
      end

    end

    describe 'an unsuccessful response' do

      before do
        response.stub(:body) { bad_faraday_body }
      end
      
      it 'should return false' do
        success_status.should eq( false )
      end

    end

  end

  describe "#successful" do

    before do
      Wyatt::Netsuite::Response.any_instance.stub(:handle_exception)
    end

    let(:successful) { response.successful }

    it "should return an array of successful Result objects" do
      successful.should eq(successful_results)
    end

  end

  describe "#failed" do

    before do
      Wyatt::Netsuite::Response.any_instance.stub(:handle_exception)
    end

    let(:failed) { response.failed }

    it "should return an array of failed Result objects" do
      failed.should eq(failed_results)
    end

  end

end
