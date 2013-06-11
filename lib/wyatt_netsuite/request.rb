module Wyatt

  module Netsuite

    class Request < Wyatt::Core::Request

      def initialize(http_method, uri, params, body, options={})
        super
      end

      def self.netsuite_initialize(body)
        build(:initialize_path, body) 
      end

      def self.load(body)
        build(:load_path, body)
      end

      def self.upsert(body)
        build(:upsert_path, body)
      end

      def self.transform(body)
        build(:transform_path, body)
      end

      def self.delete(body)
        build(:delete_path, body)
      end

      def self.search(body)
        build(:search_path, body)
      end

      def self.saved_search(body)
        build(:saved_search_path, body)
      end

      private

      def marshal_body
      end

      def self.build_params
        true
      end

      def self.build(http_method, body)
        new(
          :post,
          Wyatt::Netsuite::Configuration.send(http_method),
          build_params,
          body
        )
      end

    end
  
  end

end
