require_relative "database_connector"
require_relative "connector"

class LineItem < Connector
	def initialize(product = '', quantity = '', order_id = '')
		connector
		@product = product
		@quantity = quantity
		@order_id = order_id
	end

	def create
	
	  if @product
			@con.exec "insert into line_items 
				       	VALUES(#{last_id}, 'Order', #{@order_id},
				       	#{@product['price']}, #{@quantity}, #{@product['id']}, '#{Time.now()}', '#{Time.now()}')"
	  else
	    false
	  end    	
	end

	def order_line_items(order_id)
		@con.prepare 'line_items', "select * from line_items where itemable_id = $1"
		rs = @con.exec_prepared 'line_items', [order_id]
	end


	def self.order_line_items(order_id)
		@con = DatabaseConnector.new.connect

		@con.prepare 'line_items', "select * from line_items where itemable_id = $1"
		rs = @con.exec_prepared 'line_items', [order_id]

		list_product(rs)
	end

	def last_id
		last_line_item = @con.exec "SELECT id FROM line_items ORDER BY id DESC  LIMIT 1"
		item_id = last_line_item.first

		return Time.now.to_i.to_s unless item_id
		item_id['id'].to_i + 1
	end

	def self.list_product(rs)
		puts "Product Name | Quantity | Amount\n"
    rs.each do |row|
    	product = Product.new.find(row['product_id']).first

    	if product
      	puts "%s\t | %s\t | %s\t" % [ product['name'], row['quantity'], row['amount']]
      end
    end
  end
end
