module Wyatt

  module Netsuite

    class Request < Wyatt::Request

      def initialize(http_method, uri, params, body, options={})
        super
      end

      def self.netsuite_initialize(body)
        Wyatt::Netsuite::Request.new(
          :post,
          Wyatt::Netsuite::Configuration.initialize_path,
          build_params,
          body
        )
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

      def self.build_params
        true
      end

    end
  
  end

end
