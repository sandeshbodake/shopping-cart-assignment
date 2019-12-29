require_relative '../../cart_item.rb'


describe CartItem  do
	it ':create cart item' do
		product_id = nil
		quantity = 3
	
    expect(CartItem.new(product_id, quantity).insert).to be false
	end	
	
	it ':create cart item with valid parameters' do
		product_id = 1
		quantity = 3
	
    expect(CartItem.new(product_id, quantity).insert).to be true
	end
	
	it ':create cart item with valid quntity' do
		product_id = 1
		quantity = 0
	
    expect(CartItem.new(product_id, quantity).insert).to be false
	end
end
