require 'rails_helper'

describe 'As a Merchant visiting the dashboard' do
  it 'sees the buttons to download CSV files' do
    merchant = create(:merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

    visit dashboard_path
    within '#existing-users-not-disabled-with-orders-from-merchant' do
      expect(page).to have_button('Download as CSV')

      click_button 'Download as CSV'

      expect(current_path).to eq(dashboard_users_existing_path)
    end

    visit dashboard_path
    within '#new-users-without-orders-from-merchant' do
      expect(page).to have_button('Download as CSV')

      click_button 'Download as CSV'

      expect(current_path).to eq(dashboard_users_new_path)
    end
  end
end
