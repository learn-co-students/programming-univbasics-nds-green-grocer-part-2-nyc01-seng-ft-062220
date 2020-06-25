require 'pry'
require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
    cart.each do |cart_info|
      coupons.each do |coupon|
        if cart_info[:item] == coupon[:item] && cart_info[:count] >= coupon[:num]
          unless cart_info[:item].include? (cart_info[:item] + " W/COUPON")
          new_info = {:item => cart_info[:item] + " W/COUPON", :price => coupon[:cost]/coupon[:num], :clearance => cart_info[:clearance], :count => coupon[:num]}
          cart << new_info
          else
            new_info[:count] += coupon[:num]
          end
          cart_info[:count] -= coupon[:num]
        end
      end
    end
    cart
end

def apply_clearance(cart)
  cart.each do |cart_info|
    #binding.pry
    if cart_info[:clearance] == true
      cart_info[:price] = cart_info[:price] * 80 / 100
      cart_info[:price].round(2)
      #binding.pry
    end
  end
  cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)
  total = 0
  new_cart.each do |cart_info|
    total += cart_info[:price] * cart_info[:count]
  end

  if total >= 100
    total = total * 0.9
  end
  
  total
end
