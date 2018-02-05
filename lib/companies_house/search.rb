# frozen_string_literal: true

module CompaniesHouse
  class Search
    class << self
      def companies(args)
        new(args).call('search/companies')
      end
    end

    def initialize(args)
      @start_index = args[:start_index] || 0
      @items_per_page = args[:items_per_page] || 10
      @query_string = args[:q]
    end

    def call(path)
      ::CompaniesHouse::Request.new(
        path: path,
        query: { q: query_string, start_index: start_index, items_per_page: items_per_page }
      ).call
    end

    private

    attr_reader :query_string, :start_index, :items_per_page
  end
end
