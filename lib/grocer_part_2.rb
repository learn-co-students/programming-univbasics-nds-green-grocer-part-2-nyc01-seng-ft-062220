require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  
  coupons.each do |coupon_item|
  cart_item = find_item_by_name_in_collection(coupon_item[:item], cart)
  discounted_item_name = "#{coupon_item[:item]} W/COUPON"
  discounted_cart = find_item_by_name_in_collection(discounted_item_name, cart)
  if cart_item && cart_item[:count] >= coupon_item[:num]
    if discounted_cart
      discounted_cart[:count] += coupon_item[:num]
      cart_item[:count] -= coupon_item[:num] 
    else
    discounted_cart = {
      :item => discounted_item_name,
      :price => coupon_item[:cost] / coupon_item[:num],
      :clearance => cart_item[:clearance],
      :count => coupon_item[:num]
}  
   cart << discounted_cart
   cart_item[:count] -= coupon_item[:num]
   end 
 end
end
cart
end
 
 
def apply_clearance(cart)
    updated_cart = []
  cart.map do |cart_item|
    if cart_item[:clearance]
    cart_item[:price] = (cart_item[:price] - (cart_item[:price] * 0.20)).round(2)
    end 
   cart_item
  end
end

def checkout(cart, coupons)
    total = 0
    consolidated_cart = consolidate_cart(cart)
    consolidated_cart_w_coupons = apply_coupons(consolidated_cart, coupons)
    consolidated_cart_w_coupons_and_clearance = apply_clearance(consolidated_cart_w_coupons)
   
   consolidated_cart_w_coupons_and_clearance.each do |calculating|
     total += calculating[:price] * calculating[:count]
    end 
    if total > 100
      total -= (total * 0.10)
    end
    total
end

  
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
