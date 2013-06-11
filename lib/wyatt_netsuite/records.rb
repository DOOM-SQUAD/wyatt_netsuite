module Wyatt

  module Netsuite

    module Records
      extend self

      def build_records
        SCHEMA_MANIFEST.each do |record_name, schema_file_name|
          schema_file_path = File.join(SCHEMA_PATH, schema_file_name)
          Builder.define_record(record_name, schema_file_path)
        end
      end

    end

  end

end
