require_relative "database_connector"
require_relative "connector"

class Product < Connector
  def initialize
    connector
  end

  def list_product(rs)
    puts "\n\n********** Our Products ***************\n\n"


    rs.each do |row|
      puts "%s | %s | %s" % [ row['id'] , row['name'], row['price']]
    end

    rs
  end

  def all
    rs = @con.exec "select * from products"

    list_product(rs)
  end

  def find(id)
    rs = @con.prepare 'find_by', "select id, name, price from products where id = $1"
    rs = @con.exec_prepared 'find_by', [id]
  end


  def find_by_category_name(category_name)
    query = "select products.id, products.name, products.price \
             from products \
             INNER JOIN categories on categories.id = products.category_id \
             where categories.name = $1"

    rs = @con.prepare 'category_product', query
    rs = @con.exec_prepared 'category_product', [category_name]

    list_product(rs)
  end

  def self.create(p_name, price, category_id, description)
    @con = DatabaseConnector.new.connect

    @con.exec "insert into products 
               VALUES(#{Time.now.to_i},'#{p_name}',#{price.to_f}, #{1}, '#{description}', #{category_id}, '#{Time.now()}', '#{Time.now()}')"
  end

  def self.destroy(product_id)
    @con = DatabaseConnector.new.connect

    rs = @con.prepare 'destroy_item', "delete from products where id = $1"
    rs = @con.exec_prepared 'destroy_item', [product_id]
  end
end