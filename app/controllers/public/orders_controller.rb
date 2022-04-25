class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @addresses = Address.all
    @order = Order.new
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart_item|
        order_details = OrderDetail.new
        order_details.price = cart_item.item.with_tax_price
        order_details.item_id = cart_item.item_id
        order_details.order_id = @order.id
        order_details.amount = cart_item.amount
        order_details.save
      end
      redirect_to orders_thanks_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end

  end

  def confirm
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
    @cart_items = current_customer.cart_items
    @total = 0
    @cart_items.each do |cart_item|
      @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
      @billingamount = @total + 800
    end
  end

  def index
    @orders = Order.all
    @orders = Order.where(customer_id: current_customer.id).includes(:customer).order("created_at DESC")
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :customer_id, :total_payment )
  end
end
