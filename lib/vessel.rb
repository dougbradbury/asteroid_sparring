require 'matrix'

class Vessel

  def self.vector_accessor(name)
    module_eval <<END
      def #{name}=(thing)
        @#{name} = Vector.elements(thing)
      end

      def #{name}
        @#{name}.to_a
      end
END
  end

  vector_accessor :position
  vector_accessor :velocity

  attr_accessor :orientation

  def initialize
    @position = [0,0]
    @velocity = [0,0]
  end

  def advance
    @position = @position + @velocity
  end

  def thrust
    x = Math.cos(@orientation.to_f * Math::PI)

    y = Math.sqrt(1.0 - (x * x))
    y *= -1 if x < 0
    
    @velocity += Vector[x, y]
  end
end