require 'rails_helper'

RSpec.describe 'Merchant Index Page', type: :feature do
  describe 'As a user' do
    it '' do

    end
  end
end



# Build a Merchant leaderboard available on "/merchants" that all users can see:
# ________________________________________________________________________________

# Top 10 Merchants who sold the most items this month
# -----------------------------------------------------
# Merchants who sold the most items in a month:
# this means the order_item was fulfilled in that month,
# and the order status is completed. “Items” mean units sold,
# a sum of quantities within the merchant’s order_items.
# “Month” is a calendar month. So right now in January,
# there would only be three days to look at.


# Top 10 Merchants who sold the most items last month
# ------------------------------------------------------

# Top 10 Merchants who fulfilled non-cancelled orders this month
# -----------------------------------------------------------
# Merchants who fulfilled non-cancelled orders:
# this means the merchants fulfilled their items AND
# the order status is not ‘cancelled’, but pending/completed
# orders are fine, if you filter out merchants who have
# un-fulfilled items in any order then that will satisfy
# everything

# Top 10 Merchants who fulfilled non-cancelled orders last month
# ----------------------------------------------------------

# When logged in as a user:
# __________________________________________________________________________________
# Also see top 5 merchants who have fulfilled items the fastest to my state
# -----------------------------------------------------------

# Also see top 5 merchants who have fulfilled items the fastest to my city
# -----------------------------------------------------------
