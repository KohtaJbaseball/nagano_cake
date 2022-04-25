class Admin::HomesController < ApplicationController
  def top
    @orders = Order.order('id DESC')
  end
end
