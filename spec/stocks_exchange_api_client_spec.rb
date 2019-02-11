require 'stocks_exchange_api_client'

RSpec.describe StocksExchangeApiClient do

  let(:configuration) { StocksExchangeApiClient.configure do |conf|
    conf.url = 'https://app.stex.com/api2'
    conf.option[:api_key] = 'XXXXXXXXXXXXXXXXXX'
    conf.option[:api_secret] = 'XXXXXXXXXXXXXXXX'
  end }

  it 'has a version number' do
    expect(StocksExchangeApiClient::VERSION).not_to be nil
  end
end
