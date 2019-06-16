require 'spec_helper'
require 'json'
require './app/services/coin_api_service'

describe 'Cryto Currency Exchange by CoinAPI', :vcr do
  it 'exchanges USD to BTC' do
    amount = rand(0..9999)
    res = CoinApiService.new("BTC", "USD", amount).perform
    expect(res.is_a? Numeric).to eql(true)
    expect(res != 0 || amount == 0).to eql(true)
  end

  it 'includes BTC as an asset' do
    assets = CoinApiService.assets
    expect(assets.is_a? Array).to eql(true)
    expect(assets).to include(['BTC - Bitcoin', 'BTC'])
  end
end
