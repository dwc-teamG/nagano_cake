class Item < ApplicationRecord
  has_many :cart_items
  has_many :customers, through: :cart_items
  belongs_to :genre
  has_many :order_details
  has_many :orders, through: :order_details
  has_one_attached :item_image
end
