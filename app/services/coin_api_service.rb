require 'coinapi_v1.rb'

class CoinApiService
  def initialize(source_currency, target_currency, amount)
    @source_currency = source_currency
    @target_currency = target_currency
    @amount = amount.to_f
  end


  def perform
    begin
      coin_api_key = Rails.application.credentials[Rails.env.to_sym][:coin_api_key]
      api = CoinAPIv1::Client.new(api_key: coin_api_key)
      exchange_rate = api.exchange_rates_get_specific_rate(asset_id_base: 'BTC',
                                                           asset_id_quote: 'USD')

      exchange_rate[:rate] * @amount
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end
