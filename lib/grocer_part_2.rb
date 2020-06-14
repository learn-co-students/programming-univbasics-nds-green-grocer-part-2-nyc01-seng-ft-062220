require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)

   coupons.each do |coupon|
     item_with_coupon = find_item_by_name_in_collection(coupon[:item], cart)
     
     if item_with_coupon[:count] >= coupon[:num]
     cart <<{:item => "#{coupon[:item]} W/COUPON",
       :price => coupon[:cost] / coupon[:num],
       :clearance => item_with_coupon[:clearance],
       :count => coupon[:num]}
     
    item_with_coupon[:count] -= coupon[:num] 
     
   end
 end
 cart
 end
     
     
 

def apply_clearance(cart)
 cart_with_clearance=[]
 cart.each do |item|
   if item[:clearance]==true
     item[:price]*=0.8
     item[:price].round(2)
 end    
 cart_with_clearance << item
 end 
  
  cart_with_clearance
end




def checkout(cart, coupons)
  total=0
  cart_after_discounts = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  cart_after_discounts.each do |item|
   total+= item[:price]*item[:count]
 end   
 if total >=100 
 total*=0.9
 end
 total.round(2)
end
