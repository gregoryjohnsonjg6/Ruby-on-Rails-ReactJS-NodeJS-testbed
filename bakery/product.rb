# Product handling class

# Initialized with Product configuration - count/price per pack
# and class which implements pack breakdown for order amount

module Bakery
  class Product
    attr_reader :packs, :paker

    def initialize( packs, breakdowner_klass = Backtracking )
      @packs  = packs
      @paker  = breakdowner_klass.new( packs.keys )
    end

    # Returns pack breakdown with connected prices per pack
    def cost_and_breakdown( amount )
      if amount > 0
        breakdown = paker.pack_breakdown( amount )
        if breakdown
          breakdown.each_with_object( {} ) do |( pack, count ), result|
            result[ pack ] = {
              count: count,
              price: packs[ pack ]
            } if count > 0
          end
        end
      end
    end

  end
end
