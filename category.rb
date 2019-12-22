require_relative "connector"
require_relative "database_connector"


class Category < Connector
  def initialize
    connector
  end

  def list_categories(rs)
    puts "\n\n********** Our Categories ***************\n\n"


    rs.each do |row|
      puts "%s | %s" % [ row['id'] , row['name']]
    end

  end

  def all
    rs = @con.exec "select * from categories"

    list_categories(rs)
  end

  def self.create(name, description)
    @con = DatabaseConnector.new.connect

    @con.exec "insert into categories 
               VALUES(#{Time.now.to_i},'#{name}','#{description}', '#{Time.now()}', '#{Time.now()}')"
  end
end