class CartController < ApplicationController

	include CartHelper

	before_filter :authenticate_user!, :except => [:add_to_cart, :view_order]

  def add_to_cart

  	product = Product.find(params[:product_id])
 			
 			if quantity_check?(product, params[:quantity].to_i)
 				return			 		
  		else
  			line_item = LineItem.create(product_id: params[:product_id], quantity: params[:quantity])
  	  	
  	  	line_item.line_item_total = line_item.quantity * line_item.product.price
		  	line_item.save

		  	redirect_to root_path
  		end
  end

	def remove_from_cart
		LineItem.find(params[:id]).destroy
		redirect_to :back
	end

	def edit_line_item
		line_item = LineItem.find(params[:id])

		if quantity_check?(line_item.product, params[:quantity].to_i)
			return
		else
			line_item.update(quantity: params[:quantity].to_i)
			line_item.line_item_total = line_item.quantity * line_item.product.price
		  	line_item.save
			redirect_to view_order_path
		end

	end

  def view_order
  	@line_items = LineItem.all
  end

  def checkout
  	line_items = LineItem.all
  	@order = Order.create(user_id: current_user.id)

  	@order.subtotal = 0

  	line_items.each do |line_item|
  		@order.subtotal += line_item.line_item_total
=begin
	this creates a hash, with the line_item product id as the key, and the
	quantity as the value
=end
	 		@order.order_items[line_item.product_id] = line_item.quantity
	  end

	  @order.sales_tax = @order.subtotal * 0.07
	  @order.grand_total = @order.subtotal + @order.sales_tax
	  @order.save
	
		line_items.each do |line_item|
			line_item.product.quantity -= line_item.quantity
			line_item.product.save
		end

		LineItem.destroy_all
	end



end