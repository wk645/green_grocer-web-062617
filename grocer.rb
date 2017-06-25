require "pry"

def consolidate_cart(cart)
    new_hash = Hash.new
    cart.each do |item|
        item.each do |name, info|
           info.each do |key, value|
               if new_hash[name]
                   new_hash[name][key] = value
                else
                new_hash[name] = {key => value}
                end
               end
           new_hash[name][:count] = cart.count(item)
        end
    end
    new_hash
end
           
           
def apply_coupons(cart, coupons)
    #binding.pry
    coupons.each do |coupon|
        if cart.has_key?(coupon[:item]) && coupon[:num] <= cart[coupon[:item]][:count]
            coupon_item = "#{coupon[:item]} W/COUPON"
            cart[coupon[:item]][:count] -= coupon[:num]
            if cart.has_key?("#{coupon[:item]} W/COUPON")
                cart[coupon_item][:count] += 1
                else
                cart[coupon_item] = {:price => coupon[:cost], :clearance => cart[coupon[:item]][:clearance], :count => 1}
            end
            else
            return cart
        end
    end
    cart
end

def apply_clearance(cart)
  cart.each do |item, item_info|
      if item_info[:clearance] == true
        item_info[:price] -= (item_info[:price] * 0.2)
        else
        cart
    end
      end
end

def checkout(cart, coupons)
    cart = consolidate_cart(cart)
    cart = apply_coupons(cart, coupons)
    cart = apply_clearance(cart)
    total = 0
    cart.each do |item, info|
        total += info[:price] * info[:count]
    end
    if total > 100
        total = (total * 0.9)
    end
    total
end
    
    
    
    
    













