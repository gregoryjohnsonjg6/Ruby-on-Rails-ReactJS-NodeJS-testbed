# Main 
# 2.0 gem used for Ruby 2.7 integtrity
gem "bigdecimal", "2.0.0"
require 'bigdecimal'

require_relative 'bakery/backtracking'
require_relative 'bakery/product'

module Bakery

  # Bakery Products defined as grouped list-array: product-codes; pack-count; pack-price 
  PRODUCTS = {
    'VS5' => {
      3 => '6.99',
      5 => '8.99'
    },
    'MB11' => {
      2 => '9.95',
      5 => '16.95',
      8 => '24.95'
    },
    'CF' => {
      3 => '5.95',
      5 => '9.95',
      9 => '16.99'
    }
  }

  class << self
    def products
      @@products ||= {}
    end

    def product_app( code )
      code  = code.upcase
      packs = PRODUCTS[ code ]
      if packs
        products[ code ] ||= Product.new(
          # BigDecimal used (BigDecimal.new is deprecated) for price-rounding to 2 digits.
          packs.each_with_object( {} ) { |(k, v), memo| memo[ k ] = BigDecimal( v ) }
        )
      end
    end

    def cost_and_breakdown( code, amount )
      prod = product_app( code )
      prod.cost_and_breakdown( amount ) if prod
    end
  end

end
