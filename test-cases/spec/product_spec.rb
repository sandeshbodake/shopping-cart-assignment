require_relative '../../product.rb'


describe Product  do
	it ':create product' do
		p_name = 'abcd'
		price = 500
		category_id = 1
		description = 'aaa bbb ccc ddd'
	
    expect(Product.create(p_name, price, category_id, description).is_a?(Hash)).to be_truthy
	end	
	
	it ':amount shoud greater than 0' do
		p_name = 'abcd'
		price = -500
		category_id = 1
		description = 'aaa bbb ccc ddd'
	
    expect(Product.create(p_name, price, category_id, description)).to be false
	end
	
	it ':mandatory category id' do
		p_name = 'abcd'
		price = 200
		category_id = nil
		description = 'aaa bbb ccc ddd'
	
    expect(Product.create(p_name, price, category_id, description)).to be false
	end	
	

	it ':destroy product with valid produc id' do
		test_id = 1
		expect(Product.destroy(test_id)).to be true
	end
end
