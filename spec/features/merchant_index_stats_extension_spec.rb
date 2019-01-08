require 'rails_helper'

RSpec.describe 'Merchant Index Page', type: :feature do
  describe 'As a user' do
    it '' do

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
# Go line by line to see what I have
# Can use Ian's code as a launching spot
# Might need to join all 4 tables (might not be a standard joins)



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
