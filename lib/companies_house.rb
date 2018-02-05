# frozen_string_literal: true

require 'companies_house/request'
require 'companies_house/search'
require 'companies_house/errors/api_error'
require 'companies_house/errors/authentication_error'
require 'companies_house/errors/rate_limit_error'

module CompaniesHouse
  class << self
    def api_key
      config.api_key
    end

    def api_endpoint
      config.api_endpoint
    end

    def configure
      self.config ||= ::CompaniesHouse::Configuration.new
      yield(config)
    end

    protected

    attr_accessor :config
  end

  class Configuration
    attr_accessor :api_key
    attr_reader :api_endpoint

    def initialize
      @api_endpoint = 'https://api.companieshouse.gov.uk'
    end

    def api_endpoint=(endpoint)
      @api_endpoint = endpoint || 'https://api.companieshouse.gov.uk'
    end
  end
end
