require 'rspec/autorun'
require_relative '01_ConceptsOfMotion'
require_relative 'Math'

include MathHelpers

describe "Scientific Notation" do
  it "(positive >= 10) returns valid number in scientific notation" do
    testVal = 299800000
    expect(scientificNotation(testVal)).to eq "2.998 * 10^8"
  end
  
  it "(positive < 1) returns valid number in scientific notation" do
    testVal = 0.00000845
    expect(scientificNotation(testVal)).to eq "8.450000000000001 * 10^-6"
  end
  
  it "(negative <= -10) returns valid number in scientific notation" do
    testVal = -299800000
    expect(scientificNotation(testVal)).to eq "-2.998 * 10^8"
  end
  
  it "(negative > -1) returns valid number in scientific notation" do
    testVal = -0.00000845
    expect(scientificNotation(testVal)).to eq "-8.450000000000001 * 10^-6"
  end
end

describe "Displacement" do
  it "initial X location: 1 to the final X position: 6" do
    initial = 1
    final = 6
    expect(delta(initial, final)).to eq 5
  end
end

describe "Velocity" do
  it "initial X position: 1, final X position: 6 with initial time 0s and final time 10s" do
    xinitial = 1
    xfinal = 6
    tinitial = 0
    tfinal = 10
    deltaX = delta(xinitial, xfinal)
    deltaT = delta(tinitial, tfinal)
    expect(velocity(deltaX, deltaT)).to eq 0.5
  end
end

describe "Vectors" do
  it "adds two vectors together and returns the net displacement (as a vector)" do
    vectorA = Vector.new(50, 0)
    vectorB = Vector.new(100, 45)
    netVector = vectorA.vectorAdd vectorB
    expect(netVector.magnitude).to eq 139.9
    # expect(netVector.direction).to eq 30.36
  end

  it "page 30, question 28" do
    vectorCarol = Vector.new(2, 90)
    vectorRobin = Vector.new(7.5, 180)
    netVector = vectorCarol.vectorAdd vectorRobin
    expect(netVector.magnitude).to eq 7.76
    # expect(netVector.direction).to eq -14.93
  end

  it "page 30, question 29" do
    vectorJoe = Vector.new(0.55, 0)
    vectorMax = Vector.new(3.25, 90)
    netVector = vectorJoe.vectorAdd vectorMax
    expect(netVector.magnitude).to eq 3.3
    # expect(netVector.direction).to eq 80.39
  end

  it "page 30, question 30" do
    vector1 = Vector.new((3 * 135), 90)
    vector2 = Vector.new((2 * 135), 180)
    netVector = vector1.vectorAdd vector2
    expect(netVector.magnitude).to eq 486.75
  end

  it "page 30, question 31" do
    tree = Vector.new(8, 90)
    butterflyPath = Vector.new(12, 0)
    netVector = tree.vectorAdd butterflyPath
    expect(netVector.magnitude).to eq 14.42
  end

  it "page 30, question 32" do
    displacementMag = Math::sqrt(50**2 + 50**2)
    vectorDis = Vector.new((50 / Math::cos(MathHelpers::degreesToRadians 45)), -45)
    expect(vectorDis.magnitude.round(2)).to eq 70.71
    expect(vectorDis.direction).to eq -45
  end

  it "page 30, question 33" do
    vector1 = Vector.new(130, 90)
    vector2 = Vector.new(50, 0)
    vector3 = Vector.new(40, -90)
    netVector = vector1.vectorAdd(vector2).vectorAdd(vector3)
    expect(netVector.magnitude).to eq 102.95
    expect(netVector.direction).to eq 60.94
  end

  it "page 30, question 34" do
    vector1 = Vector.new(60, 0)
    vector2 = Vector.new(40, 270)
    vector3 = Vector.new(80, 0)
    netVector = vector1.vectorAdd(vector2).vectorAdd(vector3)
    expect(netVector.magnitude).to eq 145.60
    expect(netVector.direction).to eq -15.95
  end
end
