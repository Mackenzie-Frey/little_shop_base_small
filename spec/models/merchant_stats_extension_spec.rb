require 'rails_helper'

RSpec.describe 'Merchant Index Page', type: :model do
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

      @oi_1_a = create(:fulfilled_order_item, item: @item_1, order: @order_1_a, quantity: 10, price: 10, created_at: 3.months.ago, updated_at: 2.months.ago)
      @oi_1_b = create(:fulfilled_order_item, item: @item_2, order: @order_1_b, quantity: 10, price: 10, created_at: 29.days.ago, updated_at: 27.days.ago)

      @oi_2_a = create(:fulfilled_order_item, item: @item_3, order: @order_2_a, quantity: 10, price: 10, created_at: 5.days.ago, updated_at: 4.days.ago)
      @oi_2_b = create(:fulfilled_order_item, item: @item_4, order: @order_2_b, quantity: 10, price: 10, created_at: 5.minutes.ago, updated_at: 32.minutes.ago)
      @oi_3_a = create(:fulfilled_order_item, item: @item_1, order: @order_3_a, quantity: 10, price: 10, created_at: 4.minutes.ago, updated_at: 16.minutes.ago)
      @oi_3_b = create(:fulfilled_order_item, item: @item_2, order: @order_3_b, quantity: 10, price: 10, created_at: 3.minutes.ago, updated_at: 8.minutes.ago)
      @oi_4_a = create(:fulfilled_order_item, item: @item_3, order: @order_4_a, quantity: 10, price: 10, created_at: 2.minutes.ago, updated_at: 4.minutes.ago)
      @oi_4_b = create(:fulfilled_order_item, item: @item_4, order: @order_4_b, quantity: 10, price: 10, created_at: 1.minutes.ago, updated_at: 2.minutes.ago)

      describe 'class methods' do
        it '.top_merchants_fulfilling_orders_this_month(limit)'

        expect(User.top_merchants_fulfilling_orders_this_month(3)).to eq()
        expect(User.top_merchants_fulfilling_orders_this_month(3)[0]).to eq()
        expect(User.top_merchants_fulfilling_orders_this_month(3)[1]).to eq()
        expect(User.top_merchants_fulfilling_orders_this_month(3)[2]).to eq()
      end

        it '.top_merchants_fulfilling_orders_last_month'



      end
  end
  end
end

# Step 1:
# Think about what each stat is looking for and get all of tests written with all of the test data.

# Model Tests:
# Pass in a count of how many things trying to output.
# To test for 3 things instead of 10
# def self.top_merchants_items_sold_this_month(count)

# Ex. in controller
	# @top_10_merchants_items_sold_this_month = User.top_merchants_items_sold_this_month(10)
  #   @top_10_merchants_items_sold_last_month = User.top_merchants_items_sold_last_month(10)
  #   @top_10_merchants_fulfilled_orders_this_month = User.top_merchants_fulfilled_orders_this_month(10)
  #   @top_10_merchants_fulfilled_orders_last_month = User.top_merchants_fulfilled_orders_last_month(10)

# Step 2:
# Start with Model Test
# Go line by line to see what I have
# Can use Ian's code as a launching spot
# Might need to join all 4 tables (might not be a standard joins)

# How to set local time? Or will I pass in the month?


# ________________________________________________________________________________
# Build a Merchant leaderboard available on "/merchants" that all users can see:
# ________________________________________________________________________________

# 1.  Top 10 Merchants who sold the most items this month
# -----------------------------------------------------
# Merchants who sold the most items in a month:
# this means the order_item was fulfilled in that month,
# and the order status is completed. “Items” mean units sold,
# a sum of quantities within the merchant’s order_items.
# “Month” is a calendar month. So right now in January,
# there would only be three days to look at.


# 2. Top 10 Merchants who sold the most items last month
# ------------------------------------------------------

# 3. Top 10 Merchants who fulfilled non-cancelled orders this month
# -----------------------------------------------------------
# Merchants who fulfilled non-cancelled orders:
# this means the merchants fulfilled their items AND
# the order status is not ‘cancelled’, but pending/completed
# orders are fine, if you filter out merchants who have
# un-fulfilled items in any order then that will satisfy
# everything

# 4. Top 10 Merchants who fulfilled non-cancelled orders last month
# ----------------------------------------------------------

# When logged in as a user:
# __________________________________________________________________________________
# 5. Also see top 5 merchants who have fulfilled items the fastest to my state
# -----------------------------------------------------------

# 6. Also see top 5 merchants who have fulfilled items the fastest to my city
# -----------------------------------------------------------
