module Wyatt

  module Netsuite

    class Response < Wyatt::Response

      attr_reader :raw_results, :results

      def initialize(faraday_response)
        super
        handle_exception
        @results = build_results
      end

      def success?
        super && !body[:exception]
      end

      def successful
        results.select { |result| result.success? }
      end

      def failed
        results.reject { |result| result.success? }
      end

      private

      def handle_exception
        return if success?

        exception = body[:exception]
        error     = "#{exception[:message]}: #{exception[:trace] }"
        raise Wyatt::Netsuite::Exception::NetsuiteException.new(error)
      end

      def build_results
        body.map do |result_data|
          Wyatt::Netsuite::Result.new(result_data)
        end
      end

    end

  end

end
