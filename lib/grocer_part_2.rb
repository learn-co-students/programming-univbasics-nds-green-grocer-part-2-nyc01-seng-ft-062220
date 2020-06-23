require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
cart.each do |consolidated_item|
  coupons.each do |coupon|
    if consolidated_item[:item] == coupon[:item] && consolidated_item[:count] >= coupon[:num]
    consolidated_item[:count]-=coupon[:num]
    cart << {:item => "#{consolidated_item[:item]} W/COUPON",
    :price => coupon[:cost]/coupon[:num],
    :clearance => consolidated_item[:clearance],
    :count => coupon[:num]
    }
    end
  end
end  
cart
end

def apply_clearance(cart) 
cart.map do |item|  
  if item[:clearance] == true
    item[:price] = (item[:price]*0.80).round(2)
  end
  item
end
end

def checkout(cart, coupons)
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
final_cart = apply_clearance(apply_coupons(consolidate_cart(cart),coupons)).delete_if {|item| item[:count] <=0}
answer = final_cart.sum(0){|item| item[:price] * item[:count]}
if answer > 100
  answer * 0.90
else
  answer 
end  


end
