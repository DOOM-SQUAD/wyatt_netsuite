module Wyatt

  module Netsuite

    class Result

      attr_reader :success, :trace, :message, :data

      def initialize(raw_data)
        @raw_data = raw_data
        @success  = raw_data[:success]
        @data     = raw_data[:result]
        @trace    = raw_data[:exception][:trace]   if raw_data[:exception]
        @message  = raw_data[:exception][:message] if raw_data[:exception]
      end

      def success?
        success
      end

    end

  end

end
