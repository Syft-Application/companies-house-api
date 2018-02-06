# frozen_string_literal: true

module CompaniesHouse
  module Errors
    # Specific error class for when an invalid API key is used to access the service
    class AuthenticationError < APIError
      def initialize(response = nil)
        super('Invalid API key', response)
      end
    end
  end
end
