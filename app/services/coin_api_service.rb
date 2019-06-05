require 'coinapi_v1'

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
      exchange_rate = api.exchange_rates_get_specific_rate(asset_id_base: @source_currency,
                                                           asset_id_quote: @target_currency)

      exchange_rate[:rate] * @amount
    rescue StandardError => e
      e
    end
  end

  def self.assets
    coin_api_key = Rails.application.credentials[Rails.env.to_sym][:coin_api_key]
    api = CoinAPIv1::Client.new(api_key: coin_api_key)
    @assets ||= api.metadata_list_all_assets.collect{|a| ["#{a[:asset_id]} - #{a[:name]}", a[:asset_id]]}
  end

end
