class ProductsController < ApplicationController
  def index
    if params[:sort_by]
      case params[:sort_by]
      when 'alphabetical'
        @products = Product.includes(:category).order(:name).page(params[:page])
      when 'price'
        @products = Product.includes(:category).order(:price).page(params[:page])
      when 'stock'
        @products = Product.includes(:category).order(:stock_quantity).page(params[:page])
      else
        # Default to random order
        @products = Product.includes(:category).order("RANDOM()").page(params[:page])
      end
    else
      @products = Product.includes(:category).order("RANDOM()").page(params[:page])
    end
  end

  def show
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Product not found."
    redirect_to products_path
  end
end
