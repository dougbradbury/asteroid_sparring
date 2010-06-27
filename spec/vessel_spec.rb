require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'vessel'

describe Vessel do

  before(:each) do
    @vessel = Vessel.new
    @vessel.velocity = [0, 0]
    @vessel.position = [0, 0]
    @vessel.orientation = 0
  end
  
  it "should advance horizontally" do
    @vessel.position = [0, 0]
    @vessel.velocity = [1, 0]

    @vessel.advance

    @vessel.position.should == [1, 0]
  end

  it "should thrust when oriented right" do
    @vessel.orientation = 0

    @vessel.thrust
    @vessel.advance

    @vessel.orientation.should == 0
    @vessel.velocity.should == [1, 0]
    @vessel.position.should == [1, 0]
  end

  it "should thrust when oriented down" do
    @vessel.orientation = Rational(3, 2)

    @vessel.thrust
    @vessel.advance

    @vessel.orientation.should == Rational(3, 2)

    @vessel.velocity[0].should be_close(0, 1e-10)
    @vessel.velocity[1].should be_close(-1, 1e-10)

    @vessel.position[0].should be_close(0, 1e-10)
    @vessel.position[1].should be_close(-1, 1e-10)
  end

  it "should thrust when oriented left" do
    @vessel.orientation = 1

    @vessel.thrust
    @vessel.advance

    @vessel.velocity[0].should be_close(-1, 1e-10)
    @vessel.velocity[1].should be_close(0, 1e-10)

    @vessel.position[0].should be_close(-1, 1e-10)
    @vessel.position[1].should be_close(0, 1e-10)
  end

  it "should thrust when oriented up" do
    @vessel.orientation = Rational(1, 2)

    @vessel.thrust
    @vessel.advance

    @vessel.velocity[0].should be_close(0, 1e-10)
    @vessel.velocity[1].should be_close(1, 1e-10)

    @vessel.position[0].should be_close(0, 1e-10)
    @vessel.position[1].should be_close(1, 1e-10)
  end

  it "should thrust again" do
    @vessel.orientation = Rational(1, 2)

    @vessel.thrust
    @vessel.advance
    @vessel.thrust
    @vessel.advance

    @vessel.velocity[0].should be_close(0, 1e-10)
    @vessel.velocity[1].should be_close(2, 1e-10)

    @vessel.position[0].should be_close(0, 1e-10)
    @vessel.position[1].should be_close(3, 1e-10)
  end

  it "should rotate" do
    @vessel.orientation = 0
    @vessel.rotate(0.5)
    @vessel.orientation.should == 0.5
  end

  it "should rotate past two" do
    @vessel.orientation = Rational(3, 2)
    @vessel.rotate(0.6)
    @vessel.orientation.should be_close(0.1, 1e-10)
  end

  it "should rotate clockwise through zero" do
    @vessel.orientation = Rational(1, 2)
    @vessel.rotate(-0.6)
    @vessel.orientation.should be_close(1.9, 1e-10)
  end

  it "should duplicate it's data into a hash" do
    @vessel.velocity = v = [3, 1]
    @vessel.position = p = [-1, 8]
    @vessel.orientation = o = 0.75
    hash = @vessel.to_hash
    hash.should == {:position => [-1,8], :velocity => [3,1], :orientation => 0.75}

    hash[:position][0] = 0
    @vessel.position.should == [-1, 8]

    hash[:orientation] += 2.34
    @vessel.orientation.should == 0.75
  end

  it "should have radius" do
    @vessel.radius = 12
    @vessel.radius.should == 12
  end
end