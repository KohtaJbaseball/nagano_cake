class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { a: 0, b: 1, c: 2, d: 3, e: 4 }
end
