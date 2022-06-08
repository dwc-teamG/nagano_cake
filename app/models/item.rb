class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :customers, through: :cart_items
  belongs_to :genre
  has_many :order_details
  has_many :orders, through: :order_details
  has_one_attached :item_image

  validates :name, presence: true, uniqueness: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: true

  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    item_image.variant(resize_to_limit: [width, height]).processed
  end

  scope :latest, -> {order(created_at: :desc)}

  #消費税計算用のメソッド
  def add_tax_price
    (self.price * 1.10).round
  end
end