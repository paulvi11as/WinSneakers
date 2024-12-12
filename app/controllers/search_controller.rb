class SearchController < ApplicationController
  def index
    @categories = Category.all

    # Search and filter logic
    @products = Product.includes(:category)

    if params[:query].present?
      query = params[:query].downcase
      @products = @products.where("LOWER(products.name) LIKE ? OR LOWER(products.description) LIKE ?", "%#{query}%", "%#{query}%")
    end

    if params[:category].present?
      @products = @products.where(category_id: params[:category])
    end

    @products = @products.page(params[:page]).per(21)
  end
end
