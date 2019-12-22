require_relative "product"
require_relative "coupne"
require_relative "category.rb"

class ShopKeeper

  def shop_operations
    puts "\n*******WELCOME ShopKeeper******"
    puts " "
    while true
      puts " "
      puts "0.Add Category"
      puts "1.ADD PRODUCT\n"
      puts "2.REMOVE PRODUCT\n"
      puts "3.LIST ALL PRODUCTS"
      puts "4.ADD NEW COUPNE"
      puts "5.List Coupnes"
      puts "6.List Category "
      puts "7.Exists"
      puts "What You Wanted To Do ? "

      choice_id=gets
      puts "-----------------------"
      case choice_id
        when "0\n"
          puts "Enter Name Of Category"
          category_name=gets.chomp
          puts "Enter Category Description"
          des=gets.chomp
          category=Category.create(category_name,des)
        when "1\n"
          puts "Enter Name Of Product"
          product_name=gets.chomp
          puts "Enter Price Of the Product"
          product_price=gets.chomp
          puts "Enter Product Category Id"
          category_id=gets.chomp
          puts "Enter Product Description"
          des=gets.chomp
          product=Product.create(product_name,product_price,category_id,des)

        when "2\n"
          puts "Enter Id Of Product to Remove"
          product_id=gets.chomp
          product=Product.destroy(product_id)

        when "3\n"
          p1 = Product.new
          p1.all

        when "4\n"
          puts "Enter Discount in percentage"
          discount=gets.chomp
          puts "Enter Start Date"
          start_date=gets.chomp
          puts "Enter End Date"
          end_date=gets.chomp

          coupne = Coupne.new(discount, start_date, end_date)
          coupne.create

        when "5\n"
          Coupne.all

        when "6\n"
          c1 = Category.new
          c1.all
        when "7\n"
           break
      end
    end
  end
end

