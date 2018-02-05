# frozen_string_literal: true

require 'net/http'
require 'virtus'

module CompaniesHouse
  # This class manages individual requests.
  # Users of the CompaniesHouse gem should not instantiate this class
  class Request
    include Virtus.model

    attribute :api_endpoint
    attribute :api_key
    attribute :query
    attribute :path

    def initialize(args)
      args[:query] = defaults.merge(args[:query] || {})
      super(args)
      @api_key = ::CompaniesHouse.api_key
      @api_endpoint = ::CompaniesHouse.api_endpoint
      raise ArgumentError, 'Missing API key' unless api_key
      raise ArgumentError, 'HTTP is not supported' unless uri.scheme == 'https'
    end

    def call
      response = connection.request req
      parse(response)
    end

    private

    def defaults
      {
        start_index: 0
      }
    end

    def connection
      @connection ||= Net::HTTP.new(uri.host, uri.port).tap do |conn|
        conn.use_ssl = true
      end
    end

    def req
      obj = Net::HTTP::Get.new(uri)
      obj.basic_auth api_key, ''
      obj
    end

    def uri
      uri_inst = URI(api_endpoint)
      uri_inst = URI.join(uri_inst, path)
      uri_inst.query = URI.encode_www_form(query)
      uri_inst
    end

    def parse(response)
      case response.code
      when '200'
        JSON[response.body]
      when '401'
        raise ::CompaniesHouse::Errors::AuthenticationError, response
      when '429'
        raise ::CompaniesHouse::Errors::RateLimitError, response
      else
        raise ::CompaniesHouse::Errors::APIError.new('Unknown API response', response)
      end
    end
  end
end
