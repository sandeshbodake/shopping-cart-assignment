require_relative 'product.rb'
require_relative "connector"
require_relative "line_item"
require_relative "coupne"
require 'date'
require 'time'

DEFAULT_USER = 1
MAX_AMOUNT = 10000
SEPARATER = ','
class Order < Connector
	def initialize(cart_item_ids = '', counpne_id = nil)
		connector

		@cart_item_ids = cart_item_ids
		@coupne_id = counpne_id

		@errors = []
	end

	def self.find(id)
		rs = @con.prepare 'find_by_order_id', "select * from orders where id = $1"
    rs = @con.exec_prepared 'find_by_order_id', [id]
  end

	def self.all
		@con = DatabaseConnector.new.connect

		puts "\n\n\t*************Your Orders *************\n\n"

		res = @con.exec "select * from orders"

		res.each do |row|
			puts "\nOrder Id | Total Amount\n"
			puts "%s | %s" % [ row['id'] , row['amount']]
			LineItem.order_line_items(row['id'])
			puts "\n***************************"			
		end
	end

	def buy_product
		order_id = Time.now.to_i
		order = @con.exec "insert into orders 
							 				 VALUES(#{order_id},#{DEFAULT_USER},#{0.to_f}, '#{Time.now()}', '#{Time.now()}')"
		@cart_item_ids.split(SEPARATER).each do |cart_item_id|
			cart_item = CartItem.new.find(cart_item_id).first
			return not_found_message unless cart_item
			product = Product.new.find(cart_item['product_id']).first
			return not_found_message unless product['id']
			LineItem.new(product, cart_item['quantity'], order_id).create
			# destroy_cart_item(cart_item_id)
		end
		update_order_amount(order_id, order)
		# all
  rescue StandardError
  	something_went_wrong
  	false
	end

	def destroy_cart_item(cart_item_id)
	  if cart_item_id
			@con.prepare 'destroy_cart_item', "delete from cart_items where id = $1"
    	@con.exec_prepared 'destroy_cart_item', [cart_item_id]
    	true
    else
    	false
    end
	end

	def update_order_amount(order_id, order)
		total = 0
		line_items = LineItem.order_line_items(order_id)
		line_items.each do |item|
			total += item['amount'].to_f * item['quantity'].to_f
		end

		discount = add_discount(order_id) if @coupne_id
		total = total.to_f - calculate_discount_amount(total, discount).to_f
		amount = total.to_f >= MAX_AMOUNT.to_f ? total.to_f - MAX_AMOUNT.to_f : total
		@con.exec "update orders SET amount=#{amount.to_f} where id=#{order_id}"
	end

	def calculate_discount_amount(total, discount)
		(total.to_f * discount.to_f) / 100
	end

	def add_discount(order_id)
		return 0 unless @coupne_id

		coupne = Coupne.find(@coupne_id).first
		return 0 unless coupne
		return 0 unless coupne_applicable?(coupne)

		@con.exec "insert into order_discounts 
							 VALUES(#{Time.now.to_i}, #{order_id.to_i}, #{@coupne_id}, '#{Time.now()}', '#{Time.now()}')"

		Coupne.update_end_date_time(coupne)	
		coupne['discount_percentage'].to_f
	end

	def coupne_applicable?(coupne)
		if DateTime.now() <= DateTime.parse(coupne['end_date'])
			true
		else
			@errors.push("coupne is not avaliable")
			false
		end
	end
end
