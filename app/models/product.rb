class Product < ApplicationRecord
  belongs_to :category
  has_many :product_images
end
