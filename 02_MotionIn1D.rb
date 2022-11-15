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
