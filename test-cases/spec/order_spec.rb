require_relative '../../order.rb'


describe Order  do
	it ':create cart item' do
		cart_item_ids = nil
	
    expect(Order.new(cart_item_ids).buy_product).to be false
	end	
	
	it ':destroy cart item' do
	  cart_item_id = 1
	  
	  expect(Order.new.destroy_cart_item(cart_item_id)).to be true
	end
end
