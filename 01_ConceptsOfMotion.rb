require_relative 'Math'

include MathHelpers

# Returns a provided number in scientific notation
#
# @param input [Integer/Float] a number not written in scientific notation
# @return [string] a given number in scientific notation
def scientificNotation input, exponent=0
  if input > 0
    if input >= 10.0
      sigFig = input / 10.0
      scientificNotation sigFig, exponent + 1
    elsif input < 1
      sigFig = input * 10.0
      scientificNotation sigFig, exponent - 1
    else
      "#{input} * 10^#{exponent}"
    end
  else
    if input <= -10.0
      sigFig = input / 10.0
      scientificNotation sigFig, exponent + 1
    elsif input > -1
      sigFig = input * 10.0
      scientificNotation sigFig, exponent - 1
    else
      "#{input} * 10^#{exponent}"
    end
  end
end

# Returns the displacement between two scalars - Technically should not be less than 0.
#
# @param initial [float/integer] the initial scalar quantity
# @param final [float/integer] the final scalar quantity
def delta initial, final
  final.to_f - initial.to_f
end

# Returns the velocity of an object
#
# @param xDisplacement [float] displacement of x position
# @param yDisplacement [float] displacement of time
# @return [float] the velocity of the object
def velocity xDisplacement, tDisplacement
  xDisplacement / tDisplacement
end

class Vector
  attr_accessor :magnitude, :direction

  # Creates a vector object with magnitude (scalar) and a direction (in degrees from the X axis)
  #
  # @param magnitude [Integer/Float] the scalar magnitude of the vector
  # @param direction [Integer/Float] the direction of the vector in degrees from the positive X axis
  def initialize(magnitude, direction)
    @magnitude = magnitude
    @direction = direction
  end

  # Adds two vectors together and rounds the resulting vector to 2 decimal places
  #
  # @param vectorB [vector] the second vector to add to the existing object/vector
  # @return finalVector [vector] the net displacement and direction of the two vectors
  def vectorAdd(vectorB)
    x1 = self.magnitude * Math::cos(MathHelpers::degreesToRadians self.direction)
    y1 = self.magnitude * Math::sin(MathHelpers::degreesToRadians self.direction)
    x2 = vectorB.magnitude * Math::cos(MathHelpers::degreesToRadians vectorB.direction)
    y2 = vectorB.magnitude * Math::sin(MathHelpers::degreesToRadians vectorB.direction)

    xTotal = x1 + x2
    yTotal = y1 + y2
    totalMagnitude = Math::sqrt(xTotal**2 + yTotal**2)
    totalDirection = MathHelpers::radiansToDegrees(Math::atan(yTotal / xTotal))

    finalVector = Vector.new(totalMagnitude.round(2), totalDirection.round(2))
    finalVector
  end
end