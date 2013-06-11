require 'spec_helper'

describe Wyatt::Netsuite::Records::Builder do

  let(:builder_class)     { Wyatt::Netsuite::Records::Builder }
  let(:builder)           { builder_class.new(record_name, schema_file_path) }
  let(:record_name)       { "foo_bar_baz" }
  let(:record_class_name) { "FooBarBaz" }
  let(:schema_file_path)  { "/some/file/path.yml" }

  let(:field_hash) do
    {
      'required' => {
        'required_field1' => String,
        'required_field2' => Fixnum
      },
      'optional' => {
        'optional_field1' => String,
        'optional_field2' => Fixnum
      }
    }
  end

  let(:raw_yaml_string) do
    "required:\n"                 +
    "  required_field1: String\n" +
    "  required_field2: Fixnum\n" +
    "optional:\n"                 +
    "  optional_field1: String\n" +
    "  optional_field2: Fixnum"
  end

  describe ".define_record" do

    let(:define_record) { builder_class.define_record(record_name, schema_file_path) }
    let(:builder_mock)  { mock }
    
    before do
      builder_class.stub(:new) { builder_mock }
      builder_mock.stub(:parse_yaml)
      builder_mock.stub(:define_class_constant)
      builder_mock.stub(:add_required_fields)
      builder_mock.stub(:add_optional_fields)
    end

    it "should initialize a new Builder" do
      builder_class.should_receive(:new).with(record_name, schema_file_path)
      define_record
    end

    it "should call parse yaml" do
      builder_mock.should_receive(:parse_yaml)
      define_record
    end

    it "should call define_class_constant" do
      builder_mock.should_receive(:define_class_constant)
      define_record
    end

    it "should call add_required_fields" do
      builder_mock.should_receive(:add_required_fields)
      define_record
    end 

    it "should call add_optional_fields" do
      builder_mock.should_receive(:add_optional_fields)
      define_record
    end

  end

  describe "#initialize" do

    before do
      builder_class.any_instance.stub(:constantize_record_name) { record_class_name }
    end

    it "should call constantize_record_name" do
      builder_class.any_instance.should_receive(:constantize_record_name).once.with(record_name)
      builder
    end

    it "should set record_class_name with the class-ified version" do
      builder.record_class_name.should == record_class_name
    end
    
    it "should set schema_file_path" do
      builder.schema_file_path.should == schema_file_path
    end

  end

  describe "#constantize_record_name" do
    it "should return a valid class-ified string" do
      builder.constantize_record_name(record_name).should == record_class_name
    end
  end

  describe "#parse_yaml" do

    let(:parse_yaml) { builder.parse_yaml }
    
    before do
      File.stub(:read) { raw_yaml_string }
      YAML.stub(:load) { field_hash }
    end
    
    it "should call File.read" do
      File.should_receive(:read).once.with(schema_file_path)
      parse_yaml
    end
    
    it "should call YAML::load" do
      YAML.should_receive(:load).once.with(raw_yaml_string)
      parse_yaml
    end

    it "should set the raw yaml string" do
      parse_yaml
      builder.raw_yaml_string.should == raw_yaml_string
    end

    it "should call set the field hash" do
      parse_yaml
      builder.field_hash.should == field_hash
    end

  end

  describe "#define_class_constant" do

    let(:define_class_constant) { builder.define_class_constant }

    let(:fetch_constant) do
      Wyatt::Netsuite::Records.const_get(record_class_name)
    end

    before do
      define_class_constant
    end

    it "should define a new class constant" do
      expect { fetch_constant }.to_not raise_error
    end

    it "should inherit the new class from Wyatt::Core::Record" do
      fetch_constant.superclass.should == Wyatt::Core::Record
    end

    it "should cause the new class to respond to new" do
      fetch_constant.should respond_to(:new)
    end

    it "should set the record_class" do
      builder.record_class.should == fetch_constant
    end

  end

  describe "#add_field" do

    let(:mock_class)    { Class.new }
    let(:field_name)    { 'field1' }
    let(:type)          { 'String' }
    let(:type_constant) { String }
    let(:add_field)     { builder.add_field(field_name, type) }

    before do
      stub_const("Wyatt::Netsuite::Records::#{record_class_name}", mock_class)
      builder.stub(:record_class) {  Wyatt::Netsuite::Records.const_get(record_class_name) }
      builder.stub(:type_constant) { type_constant }
      mock_class.stub(:add_field_to_class)
    end

    it "should call type_constant" do
      builder.should_receive(:type_constant).once.with(type)
      add_field
    end

    it "should call add_field_to_class" do
      mock_class.should_receive(:add_field_to_class).once.with(field_name, type_constant)
      add_field
    end

  end

  describe "#type_constant" do

    let(:type)          { 'String' }
    let(:type_constant) { builder.type_constant(type) }

    it "should call Object.const_get with the given type string" do
      Object.should_receive(:const_get).once.with(type)
      type_constant
    end

  end

end
