class StorefrontController < ApplicationController
  def all_items
  	@products = Product.all
  end

  def items_by_category
  	@category = Category.find(params[:cat_id])
=begin
Any products with the category id that was just passed through
=end
  	@products = Product.where(category_id: @category.id)
  end

  def items_by_brand
  	@brand = params[:name]
  	@products = Product.where(brand: @brand)
  end
end
