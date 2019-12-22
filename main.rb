require "date"

puts "\n****WELCOME****"
puts "\n1.USER"
puts "\n2.Admin"
puts " "
puts "who you are? "

choice_id=gets

case choice_id
  when "1\n"
    require_relative "user_mode"
    user=User.new()
    user.user_operation()
  when  "2\n"
    require_relative "shop_keeper"
    shop_keeper=ShopKeeper.new()
    shop_keeper.shop_operations()
end