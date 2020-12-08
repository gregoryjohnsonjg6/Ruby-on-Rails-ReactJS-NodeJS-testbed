# Recursive Backtracking search implementation

module Bakery
  class Backtracking
    attr_reader :packs

    def initialize( packs )
      # Backtracking greedy search from biggest pack
      @packs = packs.sort
    end

    def pack_breakdown( amount )
      # amount + 1 - all possible breakdowns would be <= amount.
      context = Context.new( amount + 1 )
      
      recursive_breakdown( context, amount, packs.count - 1,  0 )
      
      context.min_solution if context.has_solution?
    end

    private

    def recursive_breakdown( context, amount, index, count )
      pack = packs[ index ]
      div, mod = amount.divmod( pack )
      if mod.zero?  # We have solution - current pack feets amount
        new_count = count + div
        context.solution[ pack ] = div
        context.set_min( new_count )
      elsif index > 0 # Not last Pack - we can go deeper
        div.downto( 0 ) do |i|
          new_amount = amount - i * pack
          new_count  = count + i

          next_pack = packs[ index - 1 ]
          next_min_count = new_count + ( new_amount + next_pack - 1 ) / next_pack
          # Prevents "worst than current min" search
          # Extreemly speed up whole Backtracking
          break if ( next_min_count >= context.min_count )

          context.solution[ pack ] = i
          recursive_breakdown( context, new_amount, index - 1, new_count )
        end
        context.solution.delete( pack )
      end
    end

    # Inner context for recursive search
    class Context
      attr_reader :min_count, :solution, :min_solution

      def initialize( max )
        @max        = max
        @min_count  = max
        @solution   = {}
      end

      def set_min( count )
        if ( count < @min_count )
          @min_count    = count
          @min_solution = @solution.dup
        end
      end

      def has_solution?
        @min_count < @max
      end
    end

  end
end
