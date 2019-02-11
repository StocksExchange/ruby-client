module StocksExchangeApiClient
  class PublicApiV3
    class << self
      def ping
        StocksExchangeApiClient.make_api_request_v3('/public/ping')
      end

      def currencies
        StocksExchangeApiClient.make_api_request_v3('/public/currencies')
      end

      def currencies_by_id(currency_id)
        url = "/public/currencies/#{currency_id}"
        StocksExchangeApiClient.make_api_request_v3(url)
      end

      def markets
        StocksExchangeApiClient.make_api_request_v3('/public/markets')
      end

      def pairs_list_by_code(code = 'ALL')
        url = "/public/currency_pairs/list/#{code}"
        StocksExchangeApiClient.make_api_request_v3(url)
      end

      def pairs_list_by_id(id)
        url = "/public/currency_pairs/#{id}"
        StocksExchangeApiClient.make_api_request_v3(url)
      end

      def ticker
        StocksExchangeApiClient.make_api_request_v3('/public/ticker')
      end

      def ticker_by_pair_id(id)
        url = "/public/ticker/#{id}"
        StocksExchangeApiClient.make_api_request_v3(url)
      end

      def trades(currency_pair_id, params)
        url = "/public/trades/#{currency_pair_id}"
        StocksExchangeApiClient.make_api_request_v3(url, params)
      end

      def orderbook_by_pair_id(id, params)
        url = "/public/orderbook/#{id}"
        StocksExchangeApiClient.make_api_request_v3(url, params)
      end

      def chart(currency_pair_id, time_start, time_end, params, candles_type)
        url = "/public/chart/#{currency_pair_id}/#{candles_type.nil? ? '1' : candles_type}"
        params['timeStart'] = time_start
        params['timeEnd'] = time_end
        StocksExchangeApiClient.make_api_request_v3(url, params)
      end
    end
  end
end
