require 'rails_helper'

describe 'As a Merchant visiting the dashboard' do
  it 'sees the buttons to generate the files' do
    merchant = create(:merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
    
    visit dashboard_path

    within '#existing-users-not-disabled-with-orders-from-merchant' do
      expect(page).to have_button('Download CSV')
    end
    within '#new-users-without-orders-from-merchant' do
      expect(page).to have_button('Download CSV')
    end
  end
end

#
# Downloadable Merchant User Lists
# Merchants can generate a list of email addresses for ALL EXISTING USERS who are NOT DISABLED who have
# ORDERED ITEMS from THIS MERCHANT in the past.
# The 4 columns must include: their name, email address,
# and how much money they've spent on your items,
# and how much they've spent from all merchants.
#
# Merchants can generate a list of all NEW USERS who have NEVER ORDERED from them before. Columns must
# include their name, email address, how much they've spent from other merchants,
# and how many orders they've made on the system.
#
# These user lists should be downloadable CSV files, one user per line in the CSV.
