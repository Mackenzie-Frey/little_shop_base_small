require 'rails_helper'

describe 'As a Merchant visiting the dashboard' do
  describe 'creates a table' do

    before :each do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)

      @user_1 = create(:user, name: "A User")
      @user_2 = create(:user, name: "B User")
      @user_3 = create(:user, name: "C User")
      @user_4_inactive = create(:inactive_user, name: "D User")

      @item_1 = create(:item, user: @merchant_1)
      @item_2 = create(:item, user: @merchant_2)

      @order_1 = create(:completed_order, user: @user_1)
      @order_2 = create(:completed_order, user: @user_2)
      @order_3 = create(:completed_order, user: @user_3)
      @order_4_not_completed = create(:order, user: @user_1)

      @order_item_1_not_fulfilled = create(:fulfilled_order_item, order: order, item: item_3, price: 1, quantity: 1)

      @order_item_1 = create(:order_item, order: @order_1, item: @item_1, price: 1, quantity: 1)
      @order_item_2 = create(:order_item, order: @order_2, item: @item_2, price: 1, quantity: 1)

    end

    describe 'with name, email, money spent with this merchant, money spent with all' do
      it 'for existing, not disabled users, who have ordered from current merchant' do

        data = @merchant.exiting_customer_csv

        expect(data).to eq([@user_1, @user_2])
        expect(data[0].my_revenue).to eq(100)
        expect(data[0].other_revenue).to eq(1000)
        expect(data[1].my_revenue).to eq(50)
        expect(data[1].other_revenue).to eq(500)
      end
    end

    describe 'with name, email, money spent with other merchants, # of total orders' do
     xit 'for all new users, without orders from current merchant' do

     end
   end
  end
end

# Current plan:
# Do model testing for Active Record commands

# Next step. Create the test data. -> calculate prices.
# make sure works for multiple quantity
# make disbaled user and test not getting it
# make active user never bought anything from us, test.
# make orders
# make items
# make order items
# make order items for a different merchant
# Make sure it only counts an item if the status is fulfilled


# Downloadable Merchant User Lists
# Merchants can generate a list of email addresses for ALL EXISTING USERS who are
# NOT DISABLED who have
# ORDERED ITEMS from THIS MERCHANT in the past.
# The 4 columns must include: their name, email address,
# and how much money they've spent on your items,
# and how much they've spent from all merchants.
#
# Merchants can generate a list of all NEW USERS who have NEVER ORDERED from them before.
# Columns must
# include their name, email address, how much they've spent from other merchants,
# and how many orders they've made on the system.
#
# These user lists should be downloadable CSV files, one user per line in the CSV.
