class Public::AddressController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
  end

  def create
    @address = Address.new
    @address.customer_id = current_customer.id
    @address.save
    redirect_to address_index_path
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    address = Address.find(params[:id])
    address.customer_id = current_customer.id
    address.update(address_params)
    redirect_to address_index_path(address.id)
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to address_index_path
  end

  private

  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end
end
