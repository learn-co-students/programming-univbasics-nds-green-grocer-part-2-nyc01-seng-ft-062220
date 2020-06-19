require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  coupons.each_with_index do |hash, index| #iterate over coupon hash and identify its index in array of hashes
  
  cart_item = find_item_by_name_in_collection(coupons[index][:item],cart)
  #create variable that passes through the item and the cart to return the hash of the item passed through
  
  couponed_item_by_name = "#{coupons[index][:item]} W/COUPON" #create variable to interpolate current item in interation and 'w/coupon'
  
  cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_by_name,cart) #create variable that takes in the couponed item 'w/coupon' (and returns the hash it exists within )
  
    if cart_item && cart_item[:count] >= coupons[index][:num] #if the returned cart_item hash's count is greater than the number required to qualify for coupon
    
      if cart_item_with_coupon #if the couponed item exists/qualifies for coupon 
        cart_item_with_coupon[:count] += coupons[index][:num] #return the count of the item that qualifies for coupon and 
        cart_item[:count] -= coupons[index][:num]
      else
        cart_item_with_coupon ={
          :item =>couponed_item_by_name,
          :price => coupons[index][:cost]/coupons[index][:num],
          :clearance => cart_item[:clearance],
          :count => coupons[index][:num]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[index][:num]
      end
    end
   index += 1
  end
   cart 
  end
  


  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart



def apply_clearance(cart)
  cart.each_with_index do |item, index|
    if cart[index][:clearance] #if clearance at the current iteration exists
      cart[index][:price] = (cart[index][:price] - (cart[index][:price] * 0.20)).round(2) #modify the price key to be discounted at a rounded value
    end
    index += 1
  end
  cart
end



def checkout(cart, coupons)

consolidated_cart = consolidate_cart(cart) #create variable to bring in our method to consolidate the cart
couponed_cart = apply_coupons(consolidated_cart,coupons) #bring in variable to coupon our consolidated cart
final_cart = apply_clearance(couponed_cart) #create variable for our final cart, which applies clearance to the couponed cart
#these are all arrays of hashes


total = 0  #set starting point for total

  final_cart.each_with_index do |item, index| #iterate over our final cart, which is an array of hashes.  each hash has been couponed and discounted when applicable. 
    total += (final_cart[index][:price] * final_cart[index][:count]) #use += to continue adding to the final cart with each iteration.  we are multiplying the price of each item and the number of each item
  end
    if total > 100  #if our total is greater than $100
    total -= (total * 0.1) #then we can apply an extra 10% discount
  end
  total #return final total
end
