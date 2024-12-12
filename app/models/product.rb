class Product < ApplicationRecord
  belongs_to :category
  has_many :product_images, dependent: :destroy

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name", "description", "price", "stock_quantity"]
  end

end
