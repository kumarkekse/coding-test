class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :orders

  scope :order_, -> { includes(:orders).uniq.select("count(orders.id) orders_count, max(customer_id) as customer_id").group(:customer_id) } 

  def is_recurring_until date
    created_at.beginning_of_month.to_date == date.beginning_of_month.to_date
  end

  def recurring?(date)
    created_at.beginning_of_month.to_date != date.beginning_of_month.to_date
  end

end