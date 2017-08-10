class ProductItem < ActiveRecord::Base
  
  belongs_to :item
  belongs_to :product

  scope :sold_items, -> { includes(:product, :item).select("max(product_id) as product_id,max(item_id) as item_id, sum(quantity) as sold_quantity").group(:item_id) } 

  scope :by_week, -> (date_range,customer) { where(product_id: customer.orders.by_week(date_range).pluck(:product_id)) }
end