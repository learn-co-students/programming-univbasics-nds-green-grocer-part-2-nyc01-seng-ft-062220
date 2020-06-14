require_relative './part_1_solution.rb'
require 'pry'

cart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3},
  {:item => "KALE",    :price => 3.00, :clearance => false, :count => 1},
  {:item => "CHEESE", :price => 6.50, :clearance => false, :count => 5}
];

coupons = [
  {:item => "AVOCADO", :num => 2, :cost => 5.00},
  {:item => "CHEESE", :num => 3, :cost => 15.00}
];

def apply_coupons(cart, coupons)
    
    cart.each_with_index do |item_hash, i1|
      item_hash.each do |k, v|
        coupons.each_with_index do |coupon, i2|
          if v == coupons[i2][:item] && cart[i1][:count] >= coupons[i2][:num]
            new_cart = {}
            new_cart[k] = v.to_s + " W/COUPON"
            new_cart[:price] = coupons[i2][:cost] / coupons[i2][:num]
            new_cart[:clearance] = cart[i1][:clearance]
            new_cart[:count] = coupons[i2][:num]
            cart[i1][:count] = cart[i1][:count] - coupons[i2][:num]
            cart << new_cart
          end
        end
      end
    end
    cart
end

def apply_clearance(cart)
  cart.each_with_index do |item_hash, i|
      if cart[i][:clearance] == true
        cart[i][:price] = (cart[i][:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  
  total = 0 
  cart.each_with_index do |item_hash, i|
   total += cart[i][:price] * cart[i][:count]
  end
  if total >= 100
    total * 0.9
  else
    total
  end

end

# binding.pry