class HomeController < ApplicationController
  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders.includes(product: :category).references(:product, :category).order('status ASC')
    #
    #
  end

  def account
    @orders = current_customer.orders.includes(product: :category).references(:product, :category).order('status ASC')
  end

  def orders
    @orders = current_customer.orders.includes(product: :category).references(:product, :category).order('status ASC')
  end

  def items
    unless params[:daterange].blank?
      from = params[:daterange].split(" - ")[0].to_date
      to = params[:daterange].split(" - ")[1].to_date
    else
      from = 1.weeks.ago
      to = Date.today
    end
    @product_items = ProductItem.by_week(from..to,current_customer).sold_items
  end

  def products
    unless params[:daterange].blank?
      from = params[:daterange].split(" - ")[0].to_date
      to = params[:daterange].split(" - ")[1].to_date
    else
      from = 1.weeks.ago
      to = Date.today
    end
    @orders = current_customer.orders.by_week(from..to).sold_products
  end

  def customers
    @total_orders = Order.count
    unless params[:daterange].blank?
      from = params[:daterange].split(" - ")[0].to_date
      to = params[:daterange].split(" - ")[1].to_date
      @orders = Order.by_week(from..to).group("customer_id").count.group_by{|key,val| val}.collect{|a,b| {a=>b.count}}.reduce Hash.new, :merge
    else
      @orders = Order.group("customer_id").count.group_by{|key,val| val}.collect{|a,b| {a=>b.count}}.reduce Hash.new, :merge
    end
    
    @month_data = Order.month_data
  end
end