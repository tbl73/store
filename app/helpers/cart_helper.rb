module CartHelper

=begin
	def quantity_check(product, quantity)
  	if product.quantity < quantity
			redirect_to product, notice: "Sorry, we only have #{product.quantity} left in stock."
		
		elsif quantity  <= 0
			redirect_to product, notice: "Sorry, you have to enter a positive number."  			
		
		else
			return false
		end

	end
=end

end
