require 'spec_helper'

describe Wyatt::Netsuite::Configuration do

  let(:config)            { Wyatt::Netsuite::Configuration }
  let(:netsuite_settings) { config::NETSUITE_SETTINGS }
  let(:domain_string)     { 'servicedomain.netsuite.com' }
  let(:base_path_string)  { '/restlet.nl' }
  let(:port_string)       { '1337' }
  let(:account_id_string) { '1234' }
  let(:login_string)      { 'bob@subgenius.com' }
  let(:password_string)   { 'hovercraft_eels' }
  let(:role_id_string)    { '7890' }
  let(:url_base)          { config.protocol + config.domain + config.base_path }

  let(:settings) do
    {
      netsuite: {
        domain:      domain_string,
        base_path:   base_path_string,
        port:        port_string,
        account_id:  account_id_string,
        login:       login_string,
        password:    password_string,
        role_id:     role_id_string,
        initialize: {
          deploy: '12',
          script: '7'
        }
      }
    }
  end

  before do
    Wyatt::Core::Configuration.stub(:raw_settings) { settings }
  end

  it 'should define the netsuite key of the configuration hash' do
    netsuite_settings.should be_kind_of(Symbol)
  end

  describe ".url" do

    it 'should return the netsuite domain' do
      config.domain.should == settings[netsuite_settings][:domain]
    end

  end
  
  describe ".base_path" do

    it 'should return the base path from the configuration data' do
      config.base_path.should == settings[netsuite_settings][:base_path]
    end

  end

  describe '.url_suffix' do

    let(:initialize_suffix) { "?deploy=12&script=7" }

    it 'should returns the url suffix containing get variables' do
      config.url_suffix(:initialize).should == initialize_suffix
    end

  end

  describe ".port" do
    it 'should return the port from the configuration data' do
      config.port.should == settings[netsuite_settings][:port]
    end
  end

  describe ".auth_string" do
    let(:auth_string) do
      'NLAuth nlauth_account=1234,' +
      'nlauth_email=bob%40subgenius.com,' +
      'nlauth_signature=hovercraft_eels,nlauth_role=7890'
    end

    it "should return the auth_string from the configuration data" do
      config.auth_string.should == auth_string
    end
  end

end
