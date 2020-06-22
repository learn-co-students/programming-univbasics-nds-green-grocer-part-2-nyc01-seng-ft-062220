require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

  coupons.each do |coupon|
    cart.each do |element|
      if coupon[:item] == element[:item] && !(coupon[:num] > element[:count])
        element[:count] -= coupon[:num]
        cart << {
          :item => "#{element[:item]} W/COUPON",
          :price => coupon[:cost]/coupon[:num],
          :clearance => element[:clearance],
          :count => coupon[:num]
        }
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |element|
    if element[:clearance] == true
      element[:price] = element[:price] - (element[:price] * 0.2)
      element[:price].round(2)
    end
  end
  cart
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
  final_cart = consolidate_cart(cart)
  final_cart = apply_coupons(final_cart,coupons)
  final_cart = apply_clearance(final_cart)
  total = 0.0
  final_cart.each do |element|
    total = total + (element[:count] * element[:price])
  end
  if total > 100 
    total -= (total * 0.1) 
  end
  total
end
