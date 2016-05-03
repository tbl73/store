module CartHelper

	def quantity_check?(product, quantity)
  	if product.quantity < quantity
			redirect_to product, notice: "Sorry, we only have #{product.quantity} left in stock."
			return true
		elsif quantity  <= 0
			redirect_to product, notice: "Sorry, you have to enter a positive number."  			
			return true
		else
			return false
		end

	end

end
