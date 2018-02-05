
# frozen_string_literal: true

require 'spec_helper'

describe CompaniesHouse::Request do
  include_context 'api config'

  subject(:request) { described_class.new(path: path).call }
  let(:path) { 'some_url_path' }

  describe '#initialize' do
    describe 'with an API key' do
      let(:params) { { q: 'some_company' } }
      let(:client) { described_class.new(path: 'some_url_path', query: params) }

      it 'sets the .api_key' do
        expect(client.api_key).to eq api_key
      end

      it 'sets a default endpoint' do
        expect(client.api_endpoint).to eq api_endpoint
      end

      it 'sets a path' do
        expect(client.path).to eq 'some_url_path'
      end

      it 'sets a query' do
        expect(client.query).to eq(q: 'some_company', start_index: 0)
      end
    end

    describe 'not using http' do
      let(:api_endpoint) { 'http://some-insecure.url' }

      it 'rejects your insecure http endpoint' do
        expect do
          described_class.new
        end.to raise_error(ArgumentError)
      end
    end

    describe 'no api_key' do
      let(:api_key) { nil }

      it 'demands an API key' do
        expect { described_class.new }.to raise_error(ArgumentError)
      end
    end
  end

  # it 'works' do
  #   expect(true).to be_truthy
  # end

  context 'when the API returns an error' do
    before do
      stub_request(:get, "#{api_endpoint}/#{path}")
        .with(basic_auth: [api_key, ''], query: { start_index: 0 })
        .to_return(body: '', status: status)
    end
    it_behaves_like 'an API that handles all errors'
  end
end
