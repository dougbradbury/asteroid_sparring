require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'collision'
require 'vessel'
describe Collision do

  include Collision
  before(:each) do
    @vessel1 = Vessel.new
    @vessel1.radius = 5

    @vessel2 = Vessel.new
    @vessel2.radius = 5
  end

  it "should collide at the same point" do
    @vessel1.position = [1, 1]
    @vessel2.position = [1, 1]
    collided?(@vessel1, @vessel2).should == true
  end

  it "should exactly collide" do
    @vessel1.position = [0, 0]
    @vessel2.position = [10, 0]
    collided?(@vessel1, @vessel2).should == true
  end
                                                 
  it "should collide when overlapping by one" do
    @vessel1.position = [0, 0]
    @vessel2.position = [9, 0]
    collided?(@vessel1, @vessel2).should == true
  end

  it "should collide on an angle" do
    @vessel1.position = [0, 0]
    @vessel2.position = [7, 7]
    collided?(@vessel1, @vessel2).should == true
  end

  it "should not collide on an angle" do
    @vessel1.position = [0, 0]
    @vessel2.position = [8, 7]
    collided?(@vessel1, @vessel2).should == false
  end

  it "should deflect head on" do
    @vessel1.position = [-4.9, 0]
    @vessel2.position = [4.9, 0]
    check_deflection([5, 0], [-5, 0], [-5, 0], [5, 0])
  end

  it "should deflect at right angles" do
    check_deflection([5, -5], [-5, -5], [-5, -5], [5, -5])
  end

  it "should deflect at 135" do
    v_comp = 5*Math.sqrt(2)
    check_deflection([v_comp, -v_comp], [-5, 0], [-5, -v_comp], [v_comp, 0])
  end

  it "should have angle between" do
    angle_between(Vector[0, 1], Vector[1,0]).should be_close(Math::PI / 2, 0.000001)
  end

  def check_deflection(vi1, vi2, vf1, vf2)
    @vessel1.position = [-4.9, 0]
    @vessel2.position = [4.9, 0]
    @vessel1.velocity = vi1
    @vessel2.velocity = vi2
    collide(@vessel1, @vessel2)
    @vessel1.velocity.should == vf1
    @vessel2.velocity.should == vf2
  end


end