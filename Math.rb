module MathHelpers
  include Math

  def degreesToRadians(degree)
    degree * (Math::PI / 180)
  end

  def radiansToDegrees(radian)
    radian * (180 / Math::PI)
  end
end

module UnitConversions
  def hoursToMinutes(hours)
    hours * 60
  end

  def milesToKilometers(miles)
    miles / (1 / 1.609)
  end

  def milesToMeters(miles)
    miles / (1 / 1609)
  end

  # @param [int/float] velocity of an object in Miles per Hour
  # @return [float] velocity of the aforereferenced object in Meters per Second
  def mphToMps(mph)
    (mph * 1.609 * 1000) / (60 * 60)
  end
end