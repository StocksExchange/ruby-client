require 'stocks_exchange_api_client/errors/configuration_error'

module StocksExchangeApiClient
  class Configuration
    URL_V2 = 'https://app.stex.com/api2'.freeze
    URL_V3 = 'https://api3.stex.com'.freeze
    attr_accessor :url, :option, :use_version, :s2s

    def initialize(url: URL_V2, option: {}, use_version: 2, s2s: false)
      if use_version == 3
        @url||= URL_V3
      else
        @url||= URL_V3
      end
      @option||= option
      @use_version||= use_version
      @s2s||= s2s
    end

    def validate!
      if use_version == 2
        unless option[:api_key] && option[:api_secret]
          raise Errors::ConfigurationError
        end
      end
      if use_version == 3 && !s2s
        unless option[:client_id] && option[:client_secret] && option[:token_object][:access_token] && option[:token_object][:refresh_token]
          raise Errors::ConfigurationError
        end
      end
      if use_version == 3 && s2s
          unless option[:token_object][:access_token]
            raise Errors::ConfigurationError
          end
      end
    end
  end
end
