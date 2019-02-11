module StocksExchangeApiClient
  class Configuration
    URL_V2 = 'https://app.stocks.exchange/api2'.freeze
    URL_V3 = 'https://api3.stex.com'.freeze
    attr_accessor :url, :option, :use_version

    def initialize
      @use_version ||= 2
      @url ||= URL_V2
    end

    def validate!
      if use_version == 2
        unless option[:api_key] && option[:api_secret]
          raise Errors::ConfigurationError
        end
      end
      if use_version == 3
        unless option[:client_id] && option[:client_secret] && option[:token_object][:access_token] && option[:token_object][:refresh_token]
          raise Errors::ConfigurationError
        end
      end
    end
  end
end
