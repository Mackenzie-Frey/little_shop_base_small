require 'rails_helper'

describe 'As a Merchant visiting the dashboard' do

  it 'sees the buttons to access CSV content' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    user_1 = create(:user, name: "A User")
    user_2 = create(:user, name: "B User")
    user_3_inactive = create(:inactive_user, name: "D User")

    item_1 = create(:item, user: merchant_1, inventory: 1000, price: 5)
    item_2 = create(:item, user: merchant_2, inventory: 1000, price: 10)

    order_1 = create(:completed_order, user: user_1)
    order_2 = create(:completed_order, user: user_2)
    order_3 = create(:completed_order, user: user_3_inactive)
    order_4_not_completed = create(:order, user: user_1)
    order_5 = create(:completed_order, user: user_1)
    order_6 = create(:completed_order, user: user_2)

    order_item_1a = create(:fulfilled_order_item, order: order_1, item: item_1, price: 5, quantity: 10)
    order_item_1b = create(:fulfilled_order_item, order: order_5, item: item_1, price: 5, quantity: 10)
    order_item_1c = create(:fulfilled_order_item, order: order_1, item: item_2, price: 10, quantity: 20)
    order_item_2a = create(:fulfilled_order_item, order: order_6, item: item_1, price: 5, quantity: 10)
    order_item_2b = create(:fulfilled_order_item, order: order_2, item: item_1, price: 5, quantity: 5)
    order_item_3a_not_fulfilled = create(:order_item, order: order_2, item: item_1, price: 10, quantity: 2)
    order_item_3b_not_fulfilled = create(:order_item, order: order_2, item: item_2, price: 10, quantity: 2)
    order_item_4 = create(:fulfilled_order_item, order: order_3, item: item_1, price: 5, quantity: 2)
    order_item_5 = create(:fulfilled_order_item, order: order_4_not_completed, item: item_1, price: 5, quantity: 5)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

    visit dashboard_path
    within '#existing-users-not-disabled-with-orders-from-merchant' do
      expect(page).to have_button('View Existing Users')

      click_button 'View Existing Users'

      expect(current_path).to eq(dashboard_users_existing_path)
      # expect(page).to have_content(user_1.name, user_1.email)
      # expect(page).to have_content(user_2.name, user_2.email)
    end

    visit dashboard_path
    within '#new-users-without-orders-from-merchant' do
      expect(page).to have_button('View New Users')

      click_button 'View New Users'

      expect(current_path).to eq(dashboard_users_new_path)

    end
  end
end
