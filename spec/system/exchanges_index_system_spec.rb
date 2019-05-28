require 'rails_helper'

RSpec.describe "Exchange Currency Process", :type => :system, js: true do
  it "shows exchanged value" do
    visit '/'
    within("#exchange_form") do
      select('BTC - Bitcoin', from: 'source_currency')
      select('USD - US Dollar', from: 'target_currency')
      fill_in 'amount', with: rand(1..9999)
    end
    click_button 'INVERTER'

    # save_and_open_page
    expect(page).to have_content("value")
  end
end
