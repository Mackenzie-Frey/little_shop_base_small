require 'rails_helper'

describe 'Merchant Index Page' do
  describe 'As a User' do
    before :each do
      @user_1 = create(:user, city: 'Austin', state: 'TX')
      @user_2 = create(:user, city: 'NYC', state: 'NY')
      @user_3 = create(:user, city: 'Denver', state: 'CO')
      @user_4 = create(:user, city: 'Los Angeles', state: 'CA')

      @merchant_1 = create(:merchant, name: 'Name 1')
      @merchant_2 = create(:merchant, name: 'Name 2')
      @merchant_3 = create(:merchant, name: 'Name 3')
      @merchant_4 = create(:merchant, name: 'Name 4')

      @item_1 = create(:item, user: @merchant_1)
      @item_2 = create(:item, user: @merchant_2)
      @item_3 = create(:item, user: @merchant_3)
      @item_4 = create(:item, user: @merchant_4)

      @order_1_a = create(:completed_order, user: @user_1)
      @order_1_b = create(:completed_order, user: @user_1)
      @order_2_a = create(:completed_order, user: @user_2)
      @order_2_b = create(:completed_order, user: @user_2)
      @order_3_a = create(:completed_order, user: @user_3)
      @order_3_b = create(:completed_order, user: @user_3)
      @order_4_a = create(:completed_order, user: @user_4)
      @order_4_b = create(:completed_order, user: @user_4)
      @order_4_c = create(:completed_order, user: @user_4)

      @order_cancelled_1 = create(:cancelled_order, user: @user_1)
      @order_cancelled_2 = create(:cancelled_order, user: @user_1)
      @order_cancelled_3 = create(:cancelled_order, user: @user_1)
      @order_cancelled_4 = create(:cancelled_order, user: @user_1)
      @order_cancelled_5 = create(:cancelled_order, user: @user_1)
      @order_cancelled_6 = create(:cancelled_order, user: @user_1)
      @order_cancelled_7 = create(:cancelled_order, user: @user_1)
      @order_cancelled_8 = create(:cancelled_order, user: @user_1)

      @order_cancelled_9 = create(:cancelled_order, user: @user_1)
      @order_cancelled_10 = create(:cancelled_order, user: @user_1)
      @order_cancelled_11 = create(:cancelled_order, user: @user_1)
      @order_cancelled_12 = create(:cancelled_order, user: @user_1)
      @order_cancelled_13 = create(:cancelled_order, user: @user_1)
      @order_cancelled_14 = create(:cancelled_order, user: @user_1)
      @order_cancelled_15 = create(:cancelled_order, user: @user_1)
      @order_cancelled_16 = create(:cancelled_order, user: @user_1)

      @oi_1_a = create(:fulfilled_order_item, item: @item_1, order: @order_1_a, quantity: 10, price: 10, created_at: 3.months.ago, updated_at: 2.months.ago)
      @oi_1_b = create(:fulfilled_order_item, item: @item_2, order: @order_1_b, quantity: 10, price: 10, created_at: 29.days.ago, updated_at: 27.days.ago)

      @oi_2_a = create(:fulfilled_order_item, item: @item_3, order: @order_2_a, quantity: 10, price: 10, created_at: 5.days.ago, updated_at: 4.days.ago)
      @oi_2_b = create(:fulfilled_order_item, item: @item_4, order: @order_2_b, quantity: 10, price: 10, created_at: 32.minutes.ago, updated_at: 5.minutes.ago)
      @oi_3_a = create(:fulfilled_order_item, item: @item_1, order: @order_3_a, quantity: 10, price: 10, created_at: 16.minutes.ago, updated_at: 4.minutes.ago)
      @oi_3_b = create(:fulfilled_order_item, item: @item_2, order: @order_3_b, quantity: 10, price: 10, created_at: 8.minutes.ago, updated_at: 3.minutes.ago)
      @oi_4_a = create(:fulfilled_order_item, item: @item_3, order: @order_4_a, quantity: 10, price: 10, created_at: 4.minutes.ago, updated_at: 2.minutes.ago)
      @oi_4_b = create(:fulfilled_order_item, item: @item_4, order: @order_4_b, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 1.minutes.ago)

      @oi_4_b_1 = create(:fulfilled_order_item, item: @item_4, order: @order_4_b, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 1.minutes.ago)
      @oi_4_b_2 = create(:fulfilled_order_item, item: @item_4, order: @order_4_b, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 1.minutes.ago)
      @oi_4_b_3 = create(:fulfilled_order_item, item: @item_4, order: @order_4_b, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 1.minutes.ago)
      @oi_4_b_4 = create(:fulfilled_order_item, item: @item_3, order: @order_4_b, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 1.minutes.ago)
      @oi_4_b_5 = create(:fulfilled_order_item, item: @item_3, order: @order_4_b, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 1.minutes.ago)
      @oi_4_b_6 = create(:fulfilled_order_item, item: @item_2, order: @order_4_b, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 1.minutes.ago)

      @oi_4_b_1_1 = create(:fulfilled_order_item, item: @item_3, order: @order_4_c, quantity: 10, price: 10, created_at: 2.months.ago, updated_at: 1.months.ago)
      @oi_4_b_1 = create(:fulfilled_order_item, item: @item_3, order: @order_4_b, quantity: 10, price: 10, created_at: 2.months.ago, updated_at: 1.months.ago)
      @oi_4_b_2 = create(:fulfilled_order_item, item: @item_3, order: @order_4_b, quantity: 10, price: 10, created_at: 2.months.ago, updated_at: 1.months.ago)
      @oi_4_b_3 = create(:fulfilled_order_item, item: @item_3, order: @order_4_b, quantity: 10, price: 10, created_at: 2.months.ago, updated_at: 1.months.ago)
      @oi_4_b_4 = create(:fulfilled_order_item, item: @item_2, order: @order_4_b, quantity: 10, price: 10, created_at: 2.months.ago, updated_at: 1.months.ago)
      @oi_4_b_5 = create(:fulfilled_order_item, item: @item_2, order: @order_4_b, quantity: 10, price: 10, created_at: 2.months.ago, updated_at: 1.months.ago)
      @oi_4_b_6 = create(:fulfilled_order_item, item: @item_1, order: @order_4_b, quantity: 10, price: 10, created_at: 2.months.ago, updated_at: 1.months.ago)

      @oi_cancelled_order_1 = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_1, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 1.minutes.ago)
      @oi_cancelled_order_2 = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_2, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 1.minutes.ago)
      @oi_cancelled_order_3 = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_3, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 1.minutes.ago)
      @oi_cancelled_order_4 = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_4, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 1.minutes.ago)
      @oi_cancelled_order_5 = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_5, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 1.minutes.ago)
      @oi_cancelled_order_6 = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_6, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 1.minutes.ago)
      @oi_cancelled_order_7 = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_7, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 1.minutes.ago)
      @oi_cancelled_order_8 = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_8, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 1.minutes.ago)

      @oi_cancelled_order_9  = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_1, quantity: 10, price: 10, created_at: 2.months.ago, updated_at: 1.months.ago)
      @oi_cancelled_order_10 = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_2, quantity: 10, price: 10, created_at: 2.months.ago, updated_at: 1.months.ago)
      @oi_cancelled_order_11 = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_3, quantity: 10, price: 10, created_at: 2.months.ago, updated_at: 1.months.ago)
      @oi_cancelled_order_12 = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_4, quantity: 10, price: 10, created_at: 2.months.ago, updated_at: 1.months.ago)
      @oi_cancelled_order_13 = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_5, quantity: 10, price: 10, created_at: 2.months.ago, updated_at: 1.months.ago)
      @oi_cancelled_order_14 = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_6, quantity: 10, price: 10, created_at: 2.months.ago, updated_at: 1.months.ago)
      @oi_cancelled_order_15 = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_7, quantity: 10, price: 10, created_at: 2.months.ago, updated_at: 1.months.ago)
      @oi_cancelled_order_16 = create(:fulfilled_order_item, item: @item_1, order: @order_cancelled_8, quantity: 10, price: 10, created_at: 2.months.ago, updated_at: 1.months.ago)

    end
      describe 'class methods' do
        it '.top_merchants_selling_items_this_month(limit)' do

          expect(User.top_merchants_selling_items_this_month(3)).to eq([@merchant_4, @merchant_3, @merchant_2])
          expect(User.top_merchants_selling_items_this_month(3)[0].items_sold).to eq(50)
        end

        it '.top_merchants_selling_items_last_month(limit)' do

          expect(User.top_merchants_selling_items_last_month(3)).to eq([@merchant_3, @merchant_2, @merchant_1])
          expect(User.top_merchants_selling_items_last_month(3)[0].items_sold).to eq(40)
        end

        it '.top_merchants_fulfilling_non_cancelled_orders_this_month(limit)' do

          expect(User.top_merchants_fulfilling_non_cancelled_orders_this_month(3)).to eq([@merchant_4, @merchant_3, @merchant_2])
        end

        it '.top_merchants_fulfilling_non_cancelled_orders_last_month(limit)' do

          expect(User.top_merchants_fulfilling_non_cancelled_orders_last_month(3)).to eq([@merchant_3, @merchant_2, @merchant_1])
        end
      end
      
      describe 'instance methods' do
        it '.top_merchants_fulfilling_fastest_orders_my_state(limit)' do

          expect(@user_4.top_merchants_fulfilling_fastest_orders_my_state(3)).to eq([@merchant_, @merchant_, @merchant_])
          expect(@user_4.top_merchants_fulfilling_fastest_orders_my_state(3)[0]).to eq(@merchant_)
          expect(@user_4.top_merchants_fulfilling_fastest_orders_my_state(3)[1]).to eq(@merchant_)
        end

        xit '.top_merchants_fulfilling_fastest_orders_my_city(limit)' do

          expect(@user_4.top_merchants_fulfilling_fastest_orders_my_city(3)).to eq([@merchant_, @merchant_, @merchant_])
          expect(@user_4.top_merchants_fulfilling_fastest_orders_my_city(3)[0]).to eq(@merchant_)
          expect(@user_4.top_merchants_fulfilling_fastest_orders_my_city(3)[1]).to eq(@merchant_)
        end
      end
    end
  end

# WHEN LOGGED IN AS ONLY A USER !!!!!!!!!!!
# __________________________________________________________________________________
# 5. Also see top 5 merchants who have fulfilled items the fastest to my state
# -----------------------------------------------------------

# 6. Also see top 5 merchants who have fulfilled items the fastest to my city
# -----------------------------------------------------------
