class User < ApplicationRecord
  has_secure_password

  has_many :items, foreign_key: 'merchant_id'
  has_many :orders
  has_many :order_items, through: :orders

  validates_presence_of :name, :address, :city, :state, :zip
  validates :email, presence: true, uniqueness: true

  enum role: [:default, :merchant, :admin]

  def self.top_3_revenue_merchants
    User.joins(items: :order_items)
      .select('users.*, sum(order_items.quantity * order_items.price) as revenue')
      .where('order_items.fulfilled=?', true)
      .order('revenue desc')
      .group(:id)
      .limit(3)
  end

  def self.merchant_fulfillment_times(order, count)
    User.joins(items: :order_items)
      .select('users.*, avg(order_items.updated_at - order_items.created_at) as avg_fulfillment_time')
      .where('order_items.fulfilled=?', true)
      .order("avg_fulfillment_time #{order}")
      .group(:id)
      .limit(count)
  end

  def self.top_3_fulfilling_merchants
    merchant_fulfillment_times(:asc, 3)
  end

  def self.bottom_3_fulfilling_merchants
    merchant_fulfillment_times(:desc, 3)
  end

  def my_pending_orders
    Order.joins(order_items: :item)
      .where("items.merchant_id=? AND orders.status=? AND order_items.fulfilled=?", self.id, 0, false)
  end

  def inventory_check(item_id)
    return nil unless self.merchant?
    Item.where(id: item_id, merchant_id: self.id).pluck(:inventory).first
  end

  def top_items_by_quantity(count)
    self.items
      .joins(:order_items)
      .select('items.*, sum(order_items.quantity) as quantity_sold')
      .where("order_items.fulfilled = ?", true)
      .group(:id)
      .order('quantity_sold desc')
      .limit(count)
  end

  def quantity_sold_percentage
    sold = self.items.joins(:order_items).where('order_items.fulfilled=?', true).sum('order_items.quantity')
    total = self.items.sum(:inventory) + sold
    {
      sold: sold,
      total: total,
      percentage: ((sold.to_f/total)*100).round(2)
    }
  end

  def top_3_states
    Item.joins('inner join order_items oi on oi.item_id=items.id inner join orders o on o.id=oi.order_id inner join users u on o.user_id=u.id')
      .select('u.state, sum(oi.quantity) as quantity_shipped')
      .where("oi.fulfilled = ? AND items.merchant_id=?", true, self.id)
      .group(:state)
      .order('quantity_shipped desc')
      .limit(3)
  end

  def top_3_cities
    Item.joins('inner join order_items oi on oi.item_id=items.id inner join orders o on o.id=oi.order_id inner join users u on o.user_id=u.id')
      .select('u.city, u.state, sum(oi.quantity) as quantity_shipped')
      .where("oi.fulfilled = ? AND items.merchant_id=?", true, self.id)
      .group(:state, :city)
      .order('quantity_shipped desc')
      .limit(3)
  end

  def most_ordering_user
    User.joins('inner join orders o on o.user_id=users.id inner join order_items oi on oi.order_id=o.id inner join items i on i.id=oi.item_id')
      .select('users.*, count(o.id) as order_count')
      .where("oi.fulfilled = ? AND i.merchant_id=?", true, self.id)
      .group(:id)
      .order('order_count desc')
      .limit(1)
      .first
  end

  def most_items_user
    User.joins('inner join orders o on o.user_id=users.id inner join order_items oi on oi.order_id=o.id inner join items i on i.id=oi.item_id')
      .select('users.*, sum(oi.quantity) as item_count')
      .where("oi.fulfilled = ? AND i.merchant_id=?", true, self.id)
      .group(:id)
      .order('item_count desc')
      .limit(1)
      .first
  end

  def top_3_revenue_users
    User.joins('inner join orders o on o.user_id=users.id inner join order_items oi on oi.order_id=o.id inner join items i on i.id=oi.item_id')
      .select('users.*, sum(oi.quantity*oi.price) as revenue')
      .where("oi.fulfilled = ? AND i.merchant_id=?", true, self.id)
      .group(:id)
      .order('revenue desc')
      .limit(3)
  end

  def existing_users
    User
    .joins(:orders, :order_items)
    .joins('join items on order_items.item_id=items.id')
    .where(role: "default")
    .where(active: true)
    .where("items.merchant_id = ?", id)
    .where("order_items.fulfilled = true")
    .group(:id)
    .order(name: :asc)
  end

  def user_revenue_by_merchant(merchant)
    self.orders.joins(:order_items)
      .where(status: :completed)
      .joins('join items on order_items.item_id=items.id')
      .where("order_items.fulfilled=?", true)
      .where("items.merchant_id = ?", merchant.id)
      .sum('order_items.quantity * order_items.price')
  end

  def all_revenue
    self.orders.joins(:order_items)
      .where(status: :completed)
      .where("order_items.fulfilled=?", true)
      .sum('order_items.quantity * order_items.price')
  end

  def existing_users_by_id
    User
    .joins(:orders, :order_items)
    .joins('join items on order_items.item_id=items.id')
    .where(role: "default")
    .where(active: true)
    .where("items.merchant_id = ?", id)
    .where("order_items.fulfilled = true")
    .group(:id)
    .pluck(:id)
  end

  def new_users(previous_purchasers_id)
    User
    .where(active: true)
    .where(role: "default")
    .where.not(id: previous_purchasers_id)
    .order(name: :asc)
  end

  def self.top_merchants_selling_items_this_month(limit)
    User
    .joins(:items, {items: :order_items})
    .joins('INNER JOIN orders ON order_items.order_id = orders.id')
    .select('users.*, sum(order_items.quantity) as items_sold').group(:id)
    .where('order_items.fulfilled = ?', true)
    .where('orders.status = ?', 1)
    .where('EXTRACT(MONTH FROM order_items.updated_at) = ?', Time.now.month)
    .order('items_sold DESC')
    .limit(limit)
  end

  def self.top_merchants_selling_items_last_month(limit)
    User
    .joins(:items, {items: :order_items})
    .joins('INNER JOIN orders ON order_items.order_id = orders.id')
    .select('users.*, sum(order_items.quantity) as items_sold').group(:id)
    .where('order_items.fulfilled = ?', true)
    .where('orders.status = ?', 1)
    .where('EXTRACT(MONTH FROM order_items.updated_at) = ?', 1.month.ago.month)
    .order('items_sold DESC')
    .limit(limit)
  end

  def self.top_merchants_fulfilling_non_cancelled_orders_this_month(limit)
    User
    .joins(:items, {items: :order_items})
    .joins('INNER JOIN orders ON order_items.order_id = orders.id')
    .select('users.*, sum(order_items.quantity) as items_sold').group(:id)
    .where('order_items.fulfilled = ?', true)
    .where.not('orders.status = ?', 2)
    .where('EXTRACT(MONTH FROM order_items.updated_at) = ?', Time.now.month)
    .order('items_sold DESC')
    .limit(limit)
  end

  def self.top_merchants_fulfilling_non_cancelled_orders_last_month(limit)
    User
    .joins(:items, {items: :order_items})
    .joins('INNER JOIN orders ON order_items.order_id = orders.id')
    .select('users.*, sum(order_items.quantity) as items_sold').group(:id)
    .where('order_items.fulfilled = ?', true)
    .where.not('orders.status = ?', 2)
    .where('EXTRACT(MONTH FROM order_items.updated_at) = ?', 1.month.ago.month)
    .order('items_sold DESC')
    .limit(limit)
  end

  def self.top_merchants_fulfilling_fastest_orders_my_state(limit)
  end

  def self.top_merchants_fulfilling_fastest_orders_my_city(limit)
  end
end
