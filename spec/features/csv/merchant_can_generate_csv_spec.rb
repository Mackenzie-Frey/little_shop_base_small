require 'rails_helper'

describe 'As a Merchant visiting the dashboard' do

  it 'sees the buttons to access CSV content for existing users and content on linked path' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      user_1 = create(:user, name: "A User")
      user_2 = create(:user, name: "B User")
      user_3_inactive = create(:inactive_user, name: "C User")

      item_1 = create(:item, user: merchant_1, inventory: 1000, price: 5)
      item_2 = create(:item, user: merchant_2, inventory: 1000, price: 10)

      order_1 = create(:completed_order, user: user_1)
      order_2 = create(:completed_order, user: user_2)
      order_3 = create(:completed_order, user: user_3_inactive)
      order_5 = create(:completed_order, user: user_1)
      order_6 = create(:completed_order, user: user_2)

     order_item_1a = create(:fulfilled_order_item, order: order_1, item: item_1, price: 5, quantity: 10)
     order_item_1b = create(:fulfilled_order_item, order: order_5, item: item_1, price: 5, quantity: 10)
     order_item_1c = create(:fulfilled_order_item, order: order_1, item: item_2, price: 10, quantity: 20)
     order_item_2a = create(:fulfilled_order_item, order: order_6, item: item_1, price: 5, quantity: 10)
     order_item_2b = create(:fulfilled_order_item, order: order_2, item: item_1, price: 5, quantity: 5)
     order_item_3a = create(:fulfilled_order_item, order: order_2, item: item_1, price: 10, quantity: 2)
     order_item_3b = create(:fulfilled_order_item, order: order_2, item: item_2, price: 10, quantity: 2)
     order_item_4 = create(:fulfilled_order_item, order: order_3, item: item_1, price: 5, quantity: 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

    visit dashboard_path

    within '#existing-users-not-disabled-with-orders-from-merchant' do
      expect(page).to have_button('View Existing Users')

      click_button 'View Existing Users'

      expect(current_path).to eq(dashboard_users_existing_path)
    end

    expect(page).to have_content(user_1.name, user_1.email, 100, 300)
    expect(page).to have_content(user_2.name, user_2.email, 95, 115)
  end

  it 'sees the buttons to access CSV content for new users and content on linked path' do
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)
    merchant_5 = create(:merchant)

    item_3 = create(:item, user: merchant_3, inventory: 1000, price: 5)
    item_4 = create(:item, user: merchant_4, inventory: 1000, price: 10)
    item_5 = create(:item, user: merchant_5, inventory: 1000, price: 20)

    user_4 = create(:user, name: "User 4")
    user_5 = create(:user, name: "User 5")
    user_6 = create(:user, name: "User 6")

    order_7 = create(:completed_order, user: user_4)
    order_8 = create(:completed_order, user: user_5)

    order_item_5 = create(:fulfilled_order_item, order: order_7, item: item_3, price: 5, quantity: 10)
    order_item_6 = create(:fulfilled_order_item, order: order_8, item: item_4, price: 10, quantity: 10)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_3)

    visit dashboard_path

    within '#new-users-without-orders-from-merchant' do
      expect(page).to have_button('View New Users')

      click_button 'View New Users'

      expect(current_path).to eq(dashboard_users_new_path)
    end

    expect(page).to have_content(user_5.name, user_5.email, 1, 100)
    expect(page).to have_content(user_6.name, user_6.email, 0, 0)
  end
end
