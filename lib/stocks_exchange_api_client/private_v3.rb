module StocksExchangeApiClient
  class PrivateApiV3
    class << self
      def profile_info
        StocksExchangeApiClient.make_api_request_v3('/profile/info')
      end

      def wallets
        StocksExchangeApiClient.make_api_request_v3('/profile/wallets')
      end

      def wallets_by_id(wallet_id)
        url = "/profile/wallets/#{wallet_id}"
        StocksExchangeApiClient.make_api_request_v3(url)
      end

      def add_wallets_by_currency_id(currency_id)
        url = "/profile/wallets/#{currency_id}"
        StocksExchangeApiClient.make_api_request_v3(url, {}, :post)
      end

      def get_wallets_address(wallet_id)
        url = "/profile/wallets/address/#{wallet_id}"
        StocksExchangeApiClient.make_api_request_v3(url)
      end

      def new_wallets_address(wallet_id)
        url = "/profile/wallets/address/#{wallet_id}"
        StocksExchangeApiClient.make_api_request_v3(url, {}, :post)
      end

      def deposits(params)
        url = '/profile/deposits'
        StocksExchangeApiClient.make_api_request_v3(url, params)
      end

      def deposits_by_id(id)
        url = "/profile/deposits/#{id}"
        StocksExchangeApiClient.make_api_request_v3(url)
      end

      def withdrawals(params)
        url = '/profile/withdrawals'
        StocksExchangeApiClient.make_api_request_v3(url, params)
      end

      def withdrawals_by_id(id)
        url = "/profile/withdrawals/#{id}"
        StocksExchangeApiClient.make_api_request_v3(url)
      end

      def add_withdrawal(currency_id, amount, address, additional_address)
        url = '/profile/withdraw'
        params = {
          'currency_id' => currency_id,
          'amount' => amount,
          'address' => address
        }
        params['additional_address_parameter'] = additional_address unless additional_address.nil?
        StocksExchangeApiClient.make_api_request_v3(url, params, :post)
      end

      def cancel_withdrawal_by_id(id)
        url = "/profile/withdraw/#{id}"
        StocksExchangeApiClient.make_api_request_v3(url, {}, :delete)
      end

      def reports_orders(params)
        url = '/reports/orders'
        StocksExchangeApiClient.make_api_request_v3(url, params)
      end

      def reports_orders_by_id(order_id)
        url = "/reports/orders/#{order_id}"
        StocksExchangeApiClient.make_api_request_v3(url, {})
      end

      def all_trading_orders
        url = '/trading/orders'
        StocksExchangeApiClient.make_api_request_v3(url, {})
      end

      def delete_all_trading_orders
        url = '/trading/orders'
        StocksExchangeApiClient.make_api_request_v3(url, {}, :delete)
      end

      def trading_orders_by_pair(currency_pair_id)
        url = "/trading/orders/#{currency_pair_id}"
        StocksExchangeApiClient.make_api_request_v3(url, {})
      end

      def delete_trading_orders_by_pair(currency_pair_id)
        url = "/trading/orders/#{currency_pair_id}"
        StocksExchangeApiClient.make_api_request_v3(url, {}, :delete)
      end

      def add_trading_orders_by_pair(currency_pair_id, type, amount, price)
        url = "/trading/orders/#{currency_pair_id}"
        params = {
            'type' => type,
            'amount' => amount,
            'price' => price
        }
        StocksExchangeApiClient.make_api_request_v3(url, params, :post)
      end

      def trading_order_by_id(order_id)
        url = "/trading/order/#{order_id}"
        StocksExchangeApiClient.make_api_request_v3(url, {})
      end

      def delete_trading_order_by_id(order_id)
        url = "/trading/order/#{order_id}"
        StocksExchangeApiClient.make_api_request_v3(url, {}, :delete)
      end
    end
  end
end
