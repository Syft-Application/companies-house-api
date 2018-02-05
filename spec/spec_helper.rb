# frozen_string_literal: true

require 'webmock/rspec'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'companies_house'

RSpec.configure do |config|
  config.before(:suite) do
    # Disable all live HTTP requests
    WebMock.disable_net_connect!(allow_localhost: true)
  end
end

Dir['spec/support/**/*.rb'].each { |fn| load fn }
