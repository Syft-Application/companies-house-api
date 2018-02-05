# frozen_string_literal: true

require 'spec_helper'
describe CompaniesHouse::Search do
  include_context 'api config'

  describe '#companies' do
    subject(:request) { described_class.companies(params) }
    let(:params) do
      {
        q: query_string,
        start_index: start_index,
        items_per_page: items_per_page
      }
    end
    let(:query_string) { 'syft' }
    let(:status) { 200 }
    let(:start_index) { nil }
    let(:items_per_page) { nil }

    context 'when all results are on a single page' do
      let(:single_page) do
        {
          'items_per_page' => 10,
          'total_results' => 2,
          'start_index' => 0,
          'items' => %w[item1 item2]
        }
      end

      before do
        stub_request(:get, "#{api_endpoint}/search/companies")
          .with(
            basic_auth: [api_key, ''],
            query: { q: query_string, start_index: '0', items_per_page: '10' }
          )
          .to_return(body: single_page.to_json, status: status)
      end

      it 'returns items from the one, single page' do
        expect(request).to eq(single_page)
      end
    end

    context 'when requesting reults from page 2' do
      let(:start_index) { 1 }
      let(:items_per_page) { 1 }
      let(:page2) do
        {
          'items_per_page' => 1,
          'total_results' => 2,
          'start_index' => 1,
          'items' => %w[item2]
        }
      end

      before do
        stub_request(:get, "#{api_endpoint}/search/companies")
          .with(
            basic_auth: [api_key, ''],
            query: { q: query_string, start_index: '1', items_per_page: '1' }
          )
          .to_return(body: page2.to_json, status: status)
      end

      it 'returns items from page 2' do
        expect(request).to eq(page2)
      end
    end

    context 'when the API returns an error' do
      before do
        stub_request(:get, "#{api_endpoint}/search/companies")
          .with(
            basic_auth: [api_key, ''],
            query: { q: query_string, start_index: '0', items_per_page: '10' }
          )
          .to_return(status: status)
      end

      it_behaves_like 'an API that handles all errors'
    end
  end
end
