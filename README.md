# STEX (former Stocks.Exchange) (Ruby API client)
STEX (former Stocks.Exchange) provides all the core exchange functionality, and additional merchant tools available via the HTTP API where all returned messages are in JSON. It's much easier to work with the API by using one of the clients provided by STEX, so while this page describes the API in case you want or need to build your own client, the examples use the Ruby client.
## Requirements
- Ruby >= 2.5.1
## Dependent Libraries
- gem 'pry'
- gem 'rake'
- gem 'openssl'
- gem 'httparty'
- gem 'json'

## General
The base URL for all the requests other than public methods is 
```
https://app.stex.com/api2
https://api3.stex.com
```

## Getting started
- [Documentation](http://help.stex.com/api-integration).
- [Sandbox API V3](https://apidocs.stex.com).

To get started with the Ruby API client, here's a snippet for creating a client with existing credentials:
> In order to use the API functions, you must have an API key and API secret, which is generated in the user profile.

## Usage
```bash
gem install stocks_exchange_api_client
```

After install use for example this code!

### Example Example API V2
```ruby
require 'stocks_exchange_api_client'

StocksExchangeApiClient.configure do |conf|
  conf.url = 'https://app.stocks.exchange/api2'
  conf.api_key = '' # Your Api Key
  conf.api_secret = '' # Your Api Secret
end
 # Get information about your account
puts StocksExchangeApiClient::Private.get_info

 # Get information about active orders.
 # Params: pair, count, order, type, owner, since, end
puts StocksExchangeApiClient::Private.active_order

 # Create orders for the purchase and sale.
 # Params: type, pair, amount, rate
puts StocksExchangeApiClient::Private.trade('BUY', 'LTC_BTC', 0.1, 0.00002)

 # Cancel selected order.
 # Params: order_id 
puts StocksExchangeApiClient::Private.cancel_order(2761025)

 # Get information about all orders.
 # Params: pair, count, order, status, owner, since, end 
puts StocksExchangeApiClient::Private.trade_history

 # Get information about all closed orders from Register
 # Params: currency, since, end 
puts StocksExchangeApiClient::Private.trade_register_history

 # Get information about all orders User
 # Params: since, end 
puts StocksExchangeApiClient::Private.user_history

 # Get information about your deposits and withdrawals.
 # Params: currency, count, order, operation, status 
puts StocksExchangeApiClient::Private.trans_history

 # Get information about trade statistic.
 # Params: currency, count, order, operation, status, since, end 
puts StocksExchangeApiClient::Private.grafic

 # Generate currency wallet address.
 # Params: currency 
puts StocksExchangeApiClient::Private.generate_wallets('ONION')

 # Get information about your wallet to deposit funds.
 # Params: currency 
puts StocksExchangeApiClient::Private.deposit('ETH')

 # Withdraw your funds.
 # Params: currency, address, amount 
puts StocksExchangeApiClient::Private.withdraw('EAG', '12345', 1.001)

 # Get all available currencies with additional info.
puts StocksExchangeApiClient::Public.currencies

 # Get all available currency pairs with additional info.
puts StocksExchangeApiClient::Public.markets

 # Get currency pair with additional info.
 # Params Currency1 and Currency2 
puts StocksExchangeApiClient::Public.markets_summary('BTC', 'USDT')

 # Use it to get the recommended retail exchange rates for all currency pairs.
puts StocksExchangeApiClient::Public.ticker

 # Use it to get the new retail exchange rates for all currency pairs.
puts StocksExchangeApiClient::Public.prices

 # Used to retrieve the latest trades that have occurred for a specific market. 
 # Params Pair 
puts StocksExchangeApiClient::Public.trade_history('BTC_USDT')

 # Used to get retrieve the orderbook for a given market.
 # Params Pair 
puts StocksExchangeApiClient::Public.order_book('BTC_USDT')
```

### Example V3
```ruby
StocksExchangeApiClient.configure do |conf|
  conf.url = 'https://api3.stex.com'
  conf.use_version = 3
  conf.option = {
    client_id: '',
    client_secret: '',
    token_object: {
      access_token: '',
      refresh_token: ''
    },
    access_token_url: 'https://api3.stex.com/oauth/token',
    scope: 'trade profile reports withdrawal'
  }
end

puts StocksExchangeApiClient::PrivateApiV3.profile_info
```
## Lists Methods
- [Sandbox API V3](https://apidocs.stex.com).
```
profile_info() // Get general information about the current user.
wallets() // Get a list of user wallets.
wallets_by_id() // Single wallet information            
add_wallets_by_currency_id() // Create a wallet for given currency
get_wallets_address() // Get deposit address for given wallet
new_wallets_address() // Create new deposit address
deposits() // Get a list of deposits made by user
deposits_by_id() // Get deposit by id
withdrawals() // Get a list of withdrawals made by user
withdrawals_by_id() // Get withdrawal by id
add_withdrawal() // Create withdrawal request
cancel_withdrawal_by_id() // Cancel unconfirmed withdrawal
reports_orders() // Get past orders
reports_orders_by_id() // Get specified order details
all_trading_orders() // List your currently open orders
delete_all_trading_orders() // Delete all active orders 
trading_orders_by_pair() // List your currently open orders for given currency pair 
delete_trading_orders_by_pair() // Delete active orders for given currency pair
add_trading_orders_by_pair() // Create new order and put it to the orders processing queue
trading_order_by_id() // Get a single order
delete_trading_order_by_id() // Cancel order                   
                         
currencies() // Available Currencies
currencies_by_id() // Get currency info   
markets() // Available markets 
pairs_list_by_code() // Available currency pairs
pairs_list_by_id() // Get currency pair information 
ticker() // Tickers list for all currency pairs
ticker_by_pair_id() // Ticker for currency pair
trades() // Trades for given currency pair  
orderbook_by_pair_id() // Orderbook for given currency pair
chart() // A list of candles for given currency pair
ping() // Test API is working and get server time
```

## Common Errors
### Here is a list with common errors and their descriptions:
  1.    Invalid Key - not generated key or the key does not correspond to the a user
  2.    Invalid Sign - bad hash-code
  3.    Invalid Nonce - wrong or empty parameter Nonce
  4.    Duplicate Request - parameter Nonce is not unique
  5.    Invalid Method - this method is wrong or missing 
  6.    The credentials are invalid - not valid Api Key or Sign  	
