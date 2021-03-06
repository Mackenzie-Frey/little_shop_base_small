require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all

admin = create(:admin)
user_A = create(:user)
user_B = create(:user)
user_C = create(:user)
user_D = create(:user)
user_E = create(:user)
user_F = create(:user)
user_G = create(:user)
user_H = create(:user)
user_I = create(:user)
merchant_1 = create(:merchant)

merchant_2, merchant_3, merchant_4 = create_list(:merchant, 3)

inactive_merchant_1 = create(:inactive_merchant)
inactive_user_1 = create(:inactive_user)

item_1 = create(:item, user: merchant_1)
item_2 = create(:item, user: merchant_2)
item_3 = create(:item, user: merchant_3)
item_4 = create(:item, user: merchant_4)
create_list(:item, 10, user: merchant_1)

inactive_item_1 = create(:inactive_item, user: merchant_1)
inactive_item_2 = create(:inactive_item, user: inactive_merchant_1)

Random.new_seed
rng = Random.new

order_1 = create(:completed_order, user: user_A)
create(:fulfilled_order_item, order: order_1, item: item_1, price: 2, quantity: 7, created_at: rng.rand(3).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order_1, item: item_2, price: 2, quantity: 6, created_at: rng.rand(23).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order_1, item: item_3, price: 3, quantity: 6, created_at: rng.rand(5).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order_1, item: item_4, price: 4, quantity: 7, created_at: rng.rand(23).hour.ago, updated_at: rng.rand(59).minutes.ago)

order_2 = create(:order, user: user_A)
create(:order_item, order: order_2, item: item_1, price: 3, quantity: 6)
create(:fulfilled_order_item, order: order_2, item: item_2, price: 2, quantity: 7, created_at: rng.rand(23).days.ago, updated_at: rng.rand(23).hours.ago)

order_3 = create(:cancelled_order, user: user_A)
create(:order_item, order: order_3, item: item_2, price: 2, quantity: 1, created_at: rng.rand(23).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:order_item, order: order_3, item: item_3, price: 3, quantity: 1, created_at: rng.rand(23).hour.ago, updated_at: rng.rand(59).minutes.ago)

order_4 = create(:completed_order, user: user_A)
create(:fulfilled_order_item, order: order_4, item: item_1, price: 6, quantity: 5, created_at: rng.rand(4).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order_4, item: item_2, price: 5, quantity: 4, created_at: rng.rand(23).hour.ago, updated_at: rng.rand(59).minutes.ago)

order_5 = create(:completed_order, user: user_B)
create(:fulfilled_order_item, order: order_5, item: item_1, price: 5, quantity: 3, created_at: rng.rand(3).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order_5, item: item_2, price: 7, quantity: 4, created_at: rng.rand(3).days.ago, updated_at: rng.rand(59).minutes.ago)

order_6 = create(:completed_order, user: user_C)
create(:fulfilled_order_item, order: order_6, item: item_1, price: 9, quantity: 3, created_at: rng.rand(3).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order_6, item: item_2, price: 7, quantity: 2, created_at: rng.rand(3).days.ago, updated_at: rng.rand(59).minutes.ago)

order_7 = create(:completed_order, user: user_D)
create(:fulfilled_order_item, order: order_7, item: item_2, price: 7, quantity: 4, created_at: rng.rand(3).days.ago, updated_at: rng.rand(59).minutes.ago)

order_8 = create(:completed_order, user: user_E)
create(:fulfilled_order_item, order: order_8, item: item_2, price: 7, quantity: 5, created_at: rng.rand(3).days.ago, updated_at: rng.rand(59).minutes.ago)

order_9 = create(:completed_order, user: user_E)
create(:fulfilled_order_item, order: order_9, item: item_2, price: 3, quantity: 9, created_at: rng.rand(3).days.ago, updated_at: rng.rand(59).minutes.ago)

order_10 = create(:completed_order, user: user_F)
create(:fulfilled_order_item, order: order_10, item: item_2, price: 3, quantity: 4, created_at: rng.rand(3).days.ago, updated_at: rng.rand(59).minutes.ago)

order_11 = create(:completed_order, user: user_G)
create(:fulfilled_order_item, order: order_11, item: item_2, price: 3, quantity: 9, created_at: rng.rand(3).days.ago, updated_at: rng.rand(59).minutes.ago)

order_12 = create(:completed_order, user: user_H)
create(:fulfilled_order_item, order: order_12, item: item_2, price: 3, quantity: 6, created_at: rng.rand(3).days.ago, updated_at: rng.rand(59).minutes.ago)

order_13 = create(:completed_order, user: user_I)
create(:fulfilled_order_item, order: order_13, item: item_2, price: 3, quantity: 5, created_at: rng.rand(3).days.ago, updated_at: rng.rand(59).minutes.ago)
