class Public::CartItemsController < ApplicationController

  before_action :setup_cart_item, only: [:create, :update, :destroy]

  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    #@cart_items.each do |cart_item|
      #total_amount = cart_item.subtotal
      #@total += total_amount
    #end
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      flash[:notice] = "商品の個数が変更されました"
      redirect_to cart_items_path
    elsif @cart_item.save
      flash[:notice] = "カートに商品を追加しました"
      redirect_to cart_items_path
    else
      redirect_to item_path(@item.id)
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end



  private

  def setup_cart_item
    @cart_item = current_customer.cart_items.find_by(item_id: params[:item_id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
