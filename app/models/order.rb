class Order < ActiveRecord::Base
  belongs_to :product

  belongs_to :customer

  enum status: [:daft, :confirmed, :canceled]

  scope :sold_products, -> { includes(product: :category).select("product_id, count(product_id) as sold_quantity").where(status: 1).group(:product_id) } 

  scope :by_week, -> (date_range) { where(created_at: date_range) }

  def self.month_data
    order_data = {}
    customer_ids = []   
    Order.all.each do |a|
      m_date = a.created_at  
      m_str = m_date.strftime("%b %Y")
      unless customer_ids.include? a.customer.id # TODO need to check this logic
        customer_ids << a.customer.id 
        customer_type =  a.customer.recurring?(m_date) ? "recurring" : "new"
        if order_data[m_str].nil?
          order_data[m_str] = [customer_type] 
        else
          order_data[m_str] << customer_type 
        end  
      end   
    end
    order_data_array = []  
    order_data.each do |key, val|
      new_count = val.select{ |v| v.eql? "new" }.count
      recurring_count = val.select{ |v| v.eql? "recurring" }.count
      order_data_array << {month: key,  reccuring_customer: recurring_count,  new_customer: new_count, total: val.count}
    end   
    order_data_array    
  end
end