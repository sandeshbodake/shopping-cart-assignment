require_relative '../../line_item.rb'


describe LineItem  do
	it ':product should be present in line items' do
		product = nil
		quantity = 2
		order_id = 1
		
		expect(LineItem.new(product, quantity, order_id).create).to be false
	end
end
