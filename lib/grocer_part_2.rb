require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  counter = 0 
  while counter < coupons.length
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num] 
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else
        cart_item_with_coupon = {
          :item => couponed_item_name,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :clearance => cart_item[:clearance],
          :count => coupons[counter][:num]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[counter][:num]
      end
    end
    counter += 1 
  end
  cart
end

def apply_clearance(cart)

  cart.each do |item, data|
    if item[:clearance]
      item[:price] = (item[:price] * 0.8).round(1)
    end 
  end
  #cart
end

def checkout(cart, coupons) 
  
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart) 
  
  total = 0 
  counter = 0 
  while counter < final_cart.length
    total += final_cart[counter][:price] * final_cart[counter][:count]
    counter += 1 
  end
  if total > 100
    total = total * 0.9 
  end
  total
end