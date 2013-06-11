module Wyatt

  module Netsuite

    module Records
      extend self

      class Builder

        attr_reader :record_class_name, :schema_file_path,
                    :raw_yaml_string, :field_hash,
                    :record_class

        def self.define_record(record_name, schema_file_path)
          Builder.new(record_name, schema_file_path).tap do |builder|
            builder.parse_yaml
            builder.define_class_constant
            builder.add_required_fields
            builder.add_optional_fields
          end
        end

        def initialize(record_name, schema_file_path)
          @record_class_name = constantize_record_name(record_name)
          @schema_file_path  = schema_file_path
        end

        def constantize_record_name(record_name)
          record_name.split("_").map(&:capitalize).join
        end

        def parse_yaml
          @raw_yaml_string = File.read(schema_file_path)
          @field_hash      = YAML::load(@raw_yaml_string)
        end

        def define_class_constant
          @record_class = ::Wyatt::Netsuite::Records.const_set(
            record_class_name,
            Class.new(Wyatt::Core::Record)
          )
        end

        def add_required_fields
          required_fields.each do |field_name, type|
            add_field(field_name, type)
          end
        end

        def add_optional_fields
          optional_fields.each do |field_name, type|
            add_field(field_name, type)
          end
        end

        def add_field(field_name, type)
          record_class.add_field_to_class(field_name, type_constant(type))
        end

        def type_constant(type)
          Object.const_get(type)
        end

        def required_fields
          field_hash['required']
        end

        def optional_fields
          field_hash['optional']
        end

      end

    end
    
  end

end
