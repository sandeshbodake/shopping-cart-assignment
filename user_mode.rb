require_relative "product.rb"
require_relative "category.rb"
require_relative "cart_item"
require_relative "order"
require_relative "coupne"

class User

  def user_operation
    puts "\n*******WELCOME USER******"
    puts " "
    while true
      puts " "
      puts "0.LIST CATEGORIES\n"
      puts "1.LIST PRODUCTS\n"
      puts "2.LIST PRODUCT BY CATEGORIES\n"
      puts "3.Add Product To Cart\n"
      puts "4.Delete Product from Cart\n"
      puts "5.List Cart Items"
      puts "6.Buy Product From Cart"
      puts "7.List Orders"
      puts "8.List Coupnes"
      puts "9.Exit"
      puts " "
      puts "What You Wanted To Do ? "
      choice_id=gets
        case choice_id
          when "0\n"
            c1 = Category.new
            c1.all

          when "1\n"
            p1 = Product.new
            p1.all

          when "2\n"
            puts "Enter Category Name."
            category_name = gets.chomp
            p1 = Product.new
            search = p1.find_by_category_name(category_name)

          when "3\n"
            puts "Enter Id Of Product"
            product_id=gets.chomp

            puts "Enter Qanitity Of Product"
            qty=gets.chomp

            cart = CartItem.new(product_id, qty)
            cart.insert
            cart.all

          when "4\n"
            puts "Enter Cart Item Id"
            cart_id=gets.chomp
            cart = CartItem.new.destroy(cart_id)

          when "5\n"
            CartItem.new.all            

          when "6\n"
            puts "Enter Cart Item Ids (comma separated)"
            cart_ids = gets.chomp

            puts "Do you have any Coupne ?(yes/no)"
            choice = gets

            case choice
              when "yes\n" 
                puts "Enter Coupne Id."
                @coupne_id = gets.chomp
            end
      
            order = Order.new(cart_ids, @coupne_id)
            order.buy_product
          when "7\n"
            Order.all

          when "8\n"
            Coupne.all
          when "9\n"
          break
      end
    end
  end
end