module Wyatt

  module Netsuite

    class Request < Wyatt::Request

      attr_accessor :record_type, :

      def initialize(record_type)
        super
      end

      def self.build_initialize_request(record_type, &block)
        # TODO (JamesChristie) throw Wyatt::Netsuite::Exception here on missing data
        base_req = Wyatt::Request.new(:post, config.initialize_path, params_hash, body)
        yield base_req if block_given?
        base_req
      end

      #Wyatt::Netsuite.upsert(Wyatt::Netsuite::RecordSet.new)

      #ii = Wyatt::Netsuite::InventoryItem.new
      #ii.upsert

      #{
        #id: 123,
        #displayname: 'VENDOR-STYLE-COLOR',
        #quantityonhand: 77
      #}

      #ii = Wyatt::Netsuite::InventoryItem.new
      #ii.display_name = 'VENDOR-STYLE-COLOR'

      #Product.to_erp

      #Wyatt::Netsuite::Request.initialize_request do |req|
      #  req.record_type = 'foo'
      #end

      private

      def marshal_body
      end

    end
  
  end

end
