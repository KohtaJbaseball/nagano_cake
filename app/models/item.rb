class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details

  enum is_active: {
    on_sale: true,
    off_sale: false
  }

  def with_tax_price
    (price * 1.1).floor
  end
end
