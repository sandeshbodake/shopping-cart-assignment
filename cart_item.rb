require_relative 'product.rb'
require_relative "connector"

DEFAULT_USER = 1

class CartItem < Connector
	def initialize(product_id = nil, quantity = nil)
		connector
		@product_id = product_id
		@quantity = quantity
		@amount = calculate_amount
	end

  def find(id)
    rs = @con.prepare 'find_by', "select * from cart_items where id = $1"
    rs = @con.exec_prepared 'find_by', [id]
  end

	def calculate_amount
		product_amount.to_f * @quantity.to_f
	end

	def list_items(rs)
    puts "\n\n********** Your CartItems ***************\n\n"


    rs.each do |row|

	    product = product(row['product_id'])
	    next unless product

      puts "%s | %s | %s | %s" % [ row['id'], product['name'] , row['amount'], row['quantity']]
    end
  end

  def all  
    rs = @con.prepare 'all_cart_items', "select * from cart_items where user_id = $1"
    rs = @con.exec_prepared 'all_cart_items', [DEFAULT_USER]

    list_items(rs)
  end

  def destroy(cart_id)
  	rs = @con.prepare 'destroy_item', "delete from cart_items where cart_items.id = $1"
    rs = @con.exec_prepared 'destroy_item', [cart_id]

    all
  end

	def product_amount
		return unless product

		product['price']
	end

	def product(product_id = nil)
		product_id = product_id || @product_id
		Product.new.find(product_id).first
	end

	def insert
		@con.exec "insert into cart_items VALUES(#{Time.now.to_i},
							 #{DEFAULT_USER}, #{@product_id}, #{@quantity},
							 #{@amount.to_f}, '#{Time.now()}', '#{Time.now()}')"
	end	
end