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
    acceleration_x = Math.cos(@orientation.to_f * Math::PI)

    acceleration_y = Math.sqrt(1.0 - (acceleration_x * acceleration_x))
    acceleration_y *= -1 if acceleration_x < 0
    
    @velocity += Vector[acceleration_x, acceleration_y]
  end

  def rotate(units)
    @orientation += units
    @orientation -= 2 if @orientation >= 2
    @orientation += 2 if @orientation < 0
  end
end