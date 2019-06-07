require 'rails_helper'

feature "Exchange Currency Process Page", :type => :system, js: true do
  scenario "shows exchanged value" do
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
