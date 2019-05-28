RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, /currencydatafeed.com/ )
    .with(headers: {
      'Accept'=>'*/*'
    }).to_return(status: 200, body: '
    {
      "status": true,
      "currency": [
        {
          "currency": "USD/BRL",
          "value": "3.41325",
          "date": "2018-04-20 17:22:59",
          "type": "original"
        }
      ]
    }', headers: {})

    stub_request(:get, "https://rest.coinapi.io/v1/exchangerate/BTC/USD").
    with(
     headers: {
      'Accept'=>'application/json',
      'Accept-Encoding'=>'deflate, gzip',
      'X-Coinapi-Key'=>Rails.application.credentials[Rails.env.to_sym][:coin_api_key]
    }).
    to_return(status: 200, body: '
      {
        "time": "2017-08-09T14:31:18.3150000Z",
        "asset_id_base": "BTC",
        "asset_id_quote": "USD",
        "rate": 3260.3514321215056208129867667
      }', headers: {})

  end
end
