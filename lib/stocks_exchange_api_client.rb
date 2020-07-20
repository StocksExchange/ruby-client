require 'openssl'
require 'httparty'
require 'json'
require 'ostruct'
require 'date'

# Version
require 'stocks_exchange_api_client/version'

# Private API method
require 'stocks_exchange_api_client/private_v3'

# Private API method
require 'stocks_exchange_api_client/public_v3'

# Configuration
require 'stocks_exchange_api_client/configuration'

module StocksExchangeApiClient
  METHOD_NAME = {
      get_info: 'GetInfo',
      active_orders: 'ActiveOrders',
      trade: 'Trade',
      cancel_order: 'CancelOrder',
      trade_history: 'TradeHistory',
      trade_register_history: 'TradeRegisterHistory',
      user_history: 'UserHistory',
      trans_history: 'TransHistory',
      grafic: 'Grafic',
      generate_wallets: 'GenerateWallets',
      deposit: 'Deposit',
      withdraw: 'Withdraw'
  }.freeze

  HEX_ALGORITHM = 'sha512'.freeze
  JSON_SETTINGS = 'settings.json'.freeze

  class << self
    def configure
      yield(configuration)
    end

    def make_api_request_v3(url, params = {}, method = :get, _type = :url, auth = true)
      configuration.validate!
      post_data = URI.encode_www_form(params)
      url_full = "#{configuration.url}/#{url}#{post_data == '' ? '' : '?'}#{post_data}"
      if auth
        if method == :post
          response = HTTParty.post(url_full, body: params, headers: {
              'Authorization' => "Bearer #{get_token}",
              'Accept' => 'application/json',
              'User-Agent' => 'stocks.exchange-client'
          }).body
        end
        if method == :get
          response = HTTParty.get(url_full, headers: {
              'Authorization' => "Bearer #{get_token}",
              'Accept' => 'application/json',
              'User-Agent' => 'stocks.exchange-client'
          }).body
        end
        if method == :delete
          response = HTTParty.delete(url_full, headers: {
              'Authorization' => "Bearer #{get_token}",
              'Accept' => 'application/json',
              'User-Agent' => 'stocks.exchange-client'
          }).body
        end
      else
        if method == :post
          response = HTTParty.post(url_full, body: params, headers: {
              'Accept' => 'application/json',
              'User-Agent' => 'stocks.exchange-client'
          }).body
        end
        if method == :get
          response = HTTParty.get(url_full, headers: {
              'Accept' => 'application/json',
              'User-Agent' => 'stocks.exchange-client'
          }).body
        end
        if method == :delete
          response = HTTParty.delete(url_full, headers: {
              'Accept' => 'application/json',
              'User-Agent' => 'stocks.exchange-client'
          }).body
        end
      end
      response
    end

    def get_token
      if !configuration.s2s
        if File.exist?(JSON_SETTINGS)
                current_token = JSON.parse(File.read(JSON_SETTINGS))
              else
                current_token = {'access_token' => configuration.option[:token_object][:access_token],
                                 'refresh_token' => configuration.option[:token_object][:refresh_token],
                                 'expires_in' => nil,
                                 'expires_in_date' => nil}
              end
              if !current_token.nil? && !current_token['expires_in_date'].nil?
                return current_token['access_token'] if DateTime.parse(current_token['expires_in_date']).to_datetime > DateTime.now.to_datetime
              end
              begin
                response = HTTParty.post(configuration.option[:access_token_url], body: {
                    grant_type: 'refresh_token',
                    refresh_token: current_token['refresh_token'],
                    client_id: configuration.option[:client_id],
                    client_secret: configuration.option[:client_secret],
                    scope: configuration.option[:scope]
                }).body
                current_token = JSON.parse(response)
                current_token['expires_in_date'] = Time.at(Time.now.to_i + current_token['expires_in']).to_s
                File.write(JSON_SETTINGS, current_token.to_json)
                current_token['access_token']
              rescue StandardError => e
                puts "Rescued: #{e.inspect}"
              end
      end
      if configuration.s2s
        configuration.option[:token_object][:access_token]
      end
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
