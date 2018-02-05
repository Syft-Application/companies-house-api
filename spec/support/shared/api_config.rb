# frozen_string_literal: true

shared_context 'api config' do
  let(:api_key) { 'test-api-key' }
  let(:api_endpoint) { 'https://some-url.test' }
  before do
    CompaniesHouse.configure do |config|
      config.api_key = api_key
      config.api_endpoint = api_endpoint
    end
  end
end
