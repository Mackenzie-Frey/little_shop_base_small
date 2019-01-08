require 'rails_helper'

RSpec.describe 'Merchant Index Page', type: :feature do
  before :each do
    describe 'As a User' do
      it 'Top 10 Merchants who sold the most items THIS month' do

        visit merchants_path

      end

      it 'Top 10 Merchants who sold the most items LAST month' do

        visit merchants_path

      end

      it 'Top 10 Merchants who fulfilled NON-CANCELLED orders THIS month' do

        visit merchants_path

      end

      it 'Top 10 Merchants who fulfilled NON-CANCELLED orders LAST month' do

        visit merchants_path

      end
    end
    describe 'LOGGED IN AS A USER' do
      it 'top 5 merchants who have fulfilled items the fastest to my STATE' do

        visit merchants_path

      end

      it 'top 5 merchants who have fulfilled items the fastest to my CITY' do

        visit merchants_path

      end
    end
  end
end
