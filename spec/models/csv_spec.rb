require 'rails_helper'

describe 'As a Merchant visiting the dashboard' do
  xit 'creates a table' do

    it 'with name, email, money spent with this merchant, money spent with all' do
      it 'for existing, not disabled users, who have ordered from current merchant' do
        merchant = create(:merchant)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        expect()
      end
    end

    it 'with name, email, money spent with other merchants, # of total orders' do
     it 'for all new users, without orders from current merchant' do
       merchant = create(:merchant)
       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

     end
   end
  end
end
