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
end