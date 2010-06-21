class GameLoop
  def initialize

  end

  def register_vessel(vessel, pilot)
    @vessel = vessel
    @pilot = pilot
  end

  def play(iterations)
    commands = @pilot.get_command
    commands.each do |command|
      if command == :thrust
        @vessel.thrust
      elsif command == :rotate_cw
        @vessel.rotate(-0.5)
      end
    end    
  end
end