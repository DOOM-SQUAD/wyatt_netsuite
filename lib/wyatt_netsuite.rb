require 'wyatt'
require 'open-uri'

require_relative 'wyatt_netsuite/exception'
require_relative 'wyatt_netsuite/configuration'
require_relative 'wyatt_netsuite/request'
require_relative 'wyatt_netsuite/response'
require_relative 'wyatt_netsuite/result'

module Wyatt
  module Netsuite
    extend self

    def self.query
    end

  end

end

#Wyatt::Netsuite::Configuration.load
