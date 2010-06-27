require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'game_loop'
require 'vessel'
describe GameLoop do

  before(:each) do
    @game = GameLoop.new
    @vessel = Vessel.new
    @vessel.position = [0,0]
    @vessel.velocity = [2,2]
    @vessel.orientation = 0
    @pilot = mock("pilot", :vessel= => nil, :get_command => [])
    @game.register_vessel(@vessel, @pilot)
  end

  it "should do one thrust" do
    @pilot.should_receive(:get_command).and_return([:thrust])
    @vessel.should_receive(:thrust)

    @game.play(1)
  end

  it "should rotate" do
    @pilot.should_receive(:get_command).and_return([:rotate_cw])
    @vessel.should_receive(:rotate).with(-0.5)

    @game.play(1)
  end

  it "should give pilot his current position" do
    @pilot.should_receive(:vessel=).with({:position => [0,0], :velocity => [2,2], :orientation => 0})

    @game.play(1)
  end  
end