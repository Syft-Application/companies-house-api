# frozen_string_literal: true

shared_examples 'an error response' do
  it 'raises a specific APIError' do
    expect { request }.to raise_error do |error|
      expect(error).to be_a(error_class)
      expect(error.status).to eq(status.to_s)
      expect(error.response).to be_a(Net::HTTPResponse)
      expect(error.message).to eq(message)
    end
  end
  # rubocop:enable RSpec/ExampleLength, RSpec/MultipleExpectations
end

shared_examples 'an API that handles all errors' do
  context '401' do
    let(:status) { 401 }
    let(:message) { 'Invalid API key - HTTP 401' }
    let(:error_class) { CompaniesHouse::Errors::AuthenticationError }

    it_behaves_like 'an error response'
  end

  context '429' do
    let(:status) { 429 }
    let(:message) { 'Rate limit exceeded - HTTP 429' }
    let(:error_class) { CompaniesHouse::Errors::RateLimitError }

    it_behaves_like 'an error response'
  end

  context 'any other code' do
    let(:status) { 342 }
    let(:message) { 'Unknown API response - HTTP 342' }
    let(:error_class) { CompaniesHouse::Errors::APIError }

    it_behaves_like 'an error response'
  end
end
