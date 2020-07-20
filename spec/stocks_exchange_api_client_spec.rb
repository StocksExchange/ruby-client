require 'stocks_exchange_api_client'

RSpec.describe StocksExchangeApiClient do
  it 'has a version number' do
    expect(StocksExchangeApiClient::VERSION).not_to be nil
  end
end
