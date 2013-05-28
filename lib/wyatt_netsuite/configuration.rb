module Wyatt

  module Netsuite

    module Configuration
      extend self

      NETSUITE_SETTINGS = :netsuite

      def netsuite_settings
        Wyatt::Configuration.raw_settings[NETSUITE_SETTINGS]
      end

      def protocol
        'https://'
      end

      def domain
        netsuite_settings[:domain]
      end

      def base_path
        netsuite_settings[:base_path]
      end

      def netsuite_url
        protocol + domain + base_path
      end

      def url_suffix(operation_key)
        suffix_settings = netsuite_settings[operation_key]
        "?deploy=#{suffix_settings[:deploy]}&script=#{suffix_settings[:script]}"
      end

      def port
        netsuite_settings[:port]
      end

      def auth_string
        "NLAuth " + [
          account_id,
          login,
          password,
          role_id
        ].join(',')
      end

      def initialize_path
        netsuite_url + url_suffix(:initialize)
      end

      def load_path
        netsuite_url + url_suffix(:load)
      end

      def upsert_path
        netsuite_url + url_suffix(:upsert)
      end

      def delete_path
        netsuite_url + url_suffix(:delete)
      end

      def transform_path
        netsuite_url + url_suffix(:transform)
      end

      def search_path
        netsuite_url + url_suffix(:search)
      end

      def saved_search_path
        netsuite_url + url_suffix(:saved_search)
      end

      private

      def account_id
        "nlauth_account=#{netsuite_settings[:account_id]}"
      end

      def login
        "nlauth_email=#{URI.escape(netsuite_settings[:login], 
           Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}"
      end

      def password
        "nlauth_signature=#{netsuite_settings[:password]}"
      end

      def role_id
        "nlauth_role=#{netsuite_settings[:role_id]}"
      end
    end

  end

end
