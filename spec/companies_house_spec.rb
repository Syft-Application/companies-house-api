# frozen_string_literal: true

require 'spec_helper'

describe CompaniesHouse do
  include_context 'api config'

  describe '.configure' do
    it 'should set the api_endpoint' do
      expect(described_class.api_endpoint).to eq 'https://some-url.test'
    end

    it 'should set the api_key' do
      expect(described_class.api_key).to eq 'test-api-key'
    end

    context 'passing nil values' do
      let(:api_key) { nil }
      let(:api_endpoint) { nil }

      it 'sets a default api_endpoint' do
        expect(described_class.api_endpoint).to eq 'https://api.companieshouse.gov.uk'
      end

      it 'should allow no api_key' do
        expect(described_class.api_key).to be_nil
      end
    end

    context 'api_endpoint not set' do
      before do
        CompaniesHouse.send(:config=, ::CompaniesHouse::Configuration.new)
        CompaniesHouse.configure do |config|
          config.api_key = api_key
        end
      end

      it 'sets a default api_endpoint' do
        expect(described_class.api_endpoint).to eq 'https://api.companieshouse.gov.uk'
      end
    end
  end
end
