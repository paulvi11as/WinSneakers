class Product < ApplicationRecord
  belongs_to :category
  has_many :product_images, dependent: :destroy

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name", "description", "price", "stock_quantity"]
  end

  def available_sizes
    sizes = (5.5..12.5).step(0.5).map do |size|
      stock = [0, *1..5].sample # Random stock; 0 means "Sold Out"
      { size: size, stock: stock }
    end
    sizes
  end
end
