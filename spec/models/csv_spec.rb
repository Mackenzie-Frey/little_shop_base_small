require 'rails_helper'

describe 'As a Merchant visiting the dashboard' do
  describe 'creates a table' do

    before :each do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)

      @user_1 = create(:user, name: "A User")
      @user_2 = create(:user, name: "B User")
      @user_3 = create(:user, name: "C User")
      @user_4 = create(:inactive_user, name: "D User")
      create(:order_item, order: orders[0], item: item, price: 1, quantity: 1)
      create(:order_item, order: orders[1], item: item, price: 1, quantity: 1)

      @item_1 = create(:item, user: @merchant_1)
      @item_2 = create(:item, user: @merchant_2)

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
     it 'for all new users, without orders from current merchant' do

     end
   end
  end
end

# Next step. Create the test data.
# make disbaled user and test not getting it
# make active user never bought anything from us, test.
# make orders
# make items
# make order items
# make order items for a different merchant
