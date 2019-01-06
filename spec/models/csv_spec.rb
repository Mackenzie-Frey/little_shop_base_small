require 'rails_helper'

describe 'As a Merchant visiting the dashboard' do
  describe 'creates a table' do

    before :each do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)

      @user_1 = create(:user, name: "A User")
      @user_2 = create(:user, name: "B User")
      @user_3_inactive = create(:inactive_user, name: "D User")

      @item_1 = create(:item, user: @merchant_1, inventory: 1000, price: 5)
      @item_2 = create(:item, user: @merchant_2, inventory: 1000, price: 10)

      @order_1 = create(:completed_order, user: @user_1)
      @order_2 = create(:completed_order, user: @user_2)
      @order_3 = create(:completed_order, user: @user_3_inactive)
      @order_5 = create(:completed_order, user: @user_1)
      @order_6 = create(:completed_order, user: @user_2)

     @order_item_1a = create(:fulfilled_order_item, order: @order_1, item: @item_1, price: 5, quantity: 10)
     @order_item_1b = create(:fulfilled_order_item, order: @order_5, item: @item_1, price: 5, quantity: 10)
     @order_item_1c = create(:fulfilled_order_item, order: @order_1, item: @item_2, price: 10, quantity: 20)
     @order_item_2a = create(:fulfilled_order_item, order: @order_6, item: @item_1, price: 5, quantity: 10)
     @order_item_2b = create(:fulfilled_order_item, order: @order_2, item: @item_1, price: 5, quantity: 5)
     # @order_item_2c = create(:fulfilled_order_item, order: @order_6, item: @item_2, price: 5, quantity: 5)
     @order_item_3a = create(:fulfilled_order_item, order: @order_2, item: @item_1, price: 10, quantity: 2)
     @order_item_3b = create(:fulfilled_order_item, order: @order_2, item: @item_2, price: 10, quantity: 2)
     @order_item_4 = create(:fulfilled_order_item, order: @order_3, item: @item_1, price: 5, quantity: 2)
    end

    describe 'with name, email, money spent with this merchant, money spent with all' do
      describe 'for existing, not disabled users, who have ordered from current merchant' do

        describe 'instance methods' do
          it 'existing_users' do
            merchant_1_data = @merchant_1.existing_users
            merchant_2_data = @merchant_2.existing_users

            expect(merchant_1_data).to eq([@user_1, @user_2])

            expect(merchant_2_data).to eq([@user_1])
          end

          it '.user_revenue_by_merchant' do
            merchant_1_data = @merchant_1.existing_users
            user_1 = merchant_1_data[0]
            user_2 = merchant_1_data[1]

            # user 1 my revenue 50 + 50 + 25 (orders 1, 4 and 5, for item 1)
            expect(user_1.user_revenue_by_merchant).to eq(125)

            #orders 2 and 6, for item 1
            expect(user_2.user_revenue_by_merchant).to eq(75)
          end

          it '.all_revenue' do
            merchant_1_data = @merchant_1.existing_users
            user_1 = merchant_1_data[0]
            user_2 = merchant_1_data[1]

            # plus 200 to 125, (orders 1, 4 and 5, for item 1 & 2)
            expect(user_1.all_revenue).to eq(300)

            # order 2 and 6 and for item 1 and 2
            expect(user_2.all_revenue).to eq(115)
          end
        end
      end
    end



    describe 'with name, email, money spent with other merchants, # of total orders' do
     xit 'for all new users, without orders from current merchant' do

     end
   end
  end
end

# redo all testing above for @merchant_2

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
# These user lists should be downloadable CSV files, one user per line in the CSV
