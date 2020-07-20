
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stocks_exchange_api_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'stocks_exchange_api_client'
  spec.version       = StocksExchangeApiClient::VERSION
  spec.authors       = ['STEX']

  spec.summary       = 'STEX (former Stocks.Exchange) API client for ruby.'
  spec.description   = 'STEX (former Stocks.Exchange) provides all the core exchange functionality, and additional merchant tools available via the HTTP API where all returned messages are in JSON. Its much easier to work with the API by using one of the clients provided by STEX, so while this page describes the API in case you want or need to build your own client, the examples use the Ruby client.'
  spec.homepage      = 'https://github.com/StocksExchange/ruby-client#readme'
  spec.license       = 'MIT'

  spec.extra_rdoc_files = ['README.md']

  spec.required_ruby_version = '~> 2.2'

  spec.add_dependency 'openssl', '~> 2.1', '>= 2.1.1'
  spec.add_dependency 'httparty', '~> 0.16.2'
  spec.add_dependency 'json', '~> 2.1', '>= 2.1.0'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
