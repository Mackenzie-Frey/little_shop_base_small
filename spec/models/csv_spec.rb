require 'rails_helper'

describe 'As a Merchant visiting the dashboard' do
  describe 'creates a table' do

    before :each do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)

      @user_1 = create(:user, name: "A User")
      @user_2 = create(:user, name: "B User")
      @user_3_inactive = create(:inactive_user, name: "C User")

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
            expect(merchant_2_data).to eq([@user_1, @user_2])
          end

          it '.user_revenue_by_merchant' do
            merchant_1_data = @merchant_1.existing_users
            user_1 = merchant_1_data[0]
            user_2 = merchant_1_data[1]

            expect(user_1.user_revenue_by_merchant(@merchant_1)).to eq(100)
            expect(user_2.user_revenue_by_merchant(@merchant_1)).to eq(95)
          end

          it '.all_revenue' do
            merchant_1_data = @merchant_1.existing_users
            user_1 = merchant_1_data[0]
            user_2 = merchant_1_data[1]

            expect(user_1.all_revenue).to eq(300)
            expect(user_2.all_revenue).to eq(115)
          end
        end
      end
    end
  end

    describe 'with name, email, money spent with other merchants, # of total orders' do
     describe 'for all new - active users, without orders from current merchant' do
         it '.new_users' do
           merchant_3 = create(:merchant)
           merchant_4 = create(:merchant)
           merchant_5 = create(:merchant)

           item_3 = create(:item, user: merchant_3, inventory: 1000, price: 5)
           item_4 = create(:item, user: merchant_4, inventory: 1000, price: 10)
           item_5 = create(:item, user: merchant_5, inventory: 1000, price: 20)

           user_4 = create(:inactive_user, name: "D User")
           user_5 = create(:inactive_user, name: "E User")
           user_6 = create(:inactive_user, name: "F User")

           order_7 = create(:completed_order, user: user_4)
           order_8 = create(:completed_order, user: user_5)

           order_item_5 = create(:fulfilled_order_item, order: order_7, item: item_3, price: 5, quantity: 10)
           order_item_6 = create(:fulfilled_order_item, order: order_8, item: item_4, price: 10, quantity: 10)


           expect(merchant_3.new_users).to eq([user_5, user_6])
           expect(merchant_4.new_users).to eq([user_4, user_6])
           expect(merchant_5.new_users).to eq([user_4, user_5, user_6])
         end

         it '.count' do
           merchant_3 = create(:merchant)
           merchant_4 = create(:merchant)
           merchant_5 = create(:merchant)

           item_3 = create(:item, user: merchant_3, inventory: 1000, price: 5)
           item_4 = create(:item, user: merchant_4, inventory: 1000, price: 10)
           item_5 = create(:item, user: merchant_5, inventory: 1000, price: 20)

           user_4 = create(:inactive_user, name: "D User")
           user_5 = create(:inactive_user, name: "E User")
           user_6 = create(:inactive_user, name: "F User")

           order_7 = create(:completed_order, user: user_4)
           order_8 = create(:completed_order, user: user_5)

           order_item_5 = create(:fulfilled_order_item, order: order_7, item: item_3, price: 5, quantity: 10)
           order_item_6 = create(:fulfilled_order_item, order: order_8, item: item_4, price: 10, quantity: 10)

           expect(user_4.orders.count).to eq(1)
           expect(user_5.orders.count).to eq(1)
           expect(user_6.orders.count).to eq(0)
         end
       end
     end
   end
