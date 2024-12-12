class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).all
  end

  def show
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Product not found."
    redirect_to products_path
  end
end
