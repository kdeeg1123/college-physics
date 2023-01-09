require 'gnuplot'
require 'rspec/autorun'
require_relative '01_ConceptsOfMotion'

def uniformMotion(xi=nil, xf=nil, ti=nil, tf=nil, v=nil)
  if xi == nil
    (xf - (v * delta(ti, tf))).round(2)
  elsif xf == nil
    (xi + (v * delta(ti, tf))).round(2)
  elsif ti == nil
    (-1 * ((delta(ti, tf) / v) - tf)).round(2)
  elsif tf == nil
    ((delta(xi, xf) / v) + ti).round(2)
  elsif v == nil
    (velocity(delta(xi, xf), delta(ti, tf))).round(2)
  end
end

def setConstantAcceleration(velocity, time)
  velocity.to_f / time.to_f
end

def kinematicSolver()
  d = variables[:d] || 0
  v0 = variables[:v0] || 0
  v = variables[:v] || 0
  a = variables[:a] || 0
  t = variables[:t] || 0

  # Solve for the missing variable
  if d == 0
    d = v0 * t + 0.5 * a * t**2
  elsif v0 == 0
    v0 = (v - a * t) / t
  elsif v == 0
    v = v0 + a * t
  elsif a == 0
    a = (v - v0) / t
  elsif t == 0
    # Quadratic equation: at^2 + v0t - d = 0
    discriminant = v0**2 + 4 * a * (-d)
    if discriminant < 0
      puts "No solution"
    elsif discriminant == 0
      t = -v0 / (2 * a)
    else
      t1 = (-v0 + Math.sqrt(discriminant)) / (2 * a)
      t2 = (-v0 - Math.sqrt(discriminant)) / (2 * a)
      puts "Two solutions: #{t1} and #{t2}"
    end
  else
    puts "Error: too many variables provided"
  end

  # Return the solution
  return d
end