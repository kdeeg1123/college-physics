require 'rspec/autorun'
require_relative '02_MotionIn1D'
require_relative 'Math'

include MathHelpers
include UnitConversions


=begin
describe "Graphical descriptions" do
  it "page 64, question 3" do
    Gnuplot.open do|gp|
      Gnuplot::Plot.new(gp) do |plot|
        plot.xrange "[0:600]"
        plot.yrange "[0:350]"
        plot.title "Figure P2.3"
        plot.xlabel "t(s)"
        plot.ylabel "x(m)"
        plot.data = [
          Gnuplot::DataSet.new("x >= 0 && x <= 300 ? x : 1/0") { |ds|
            ds.with = "lines"
            ds.title = "x"
            ds.linewidth = 2
          },

          Gnuplot::DataSet.new("x >= 300 && x <= 400 ? 300 : 1/0") { |ds|
            ds.with = "lines"
            ds.title = "300"
            ds.linewidth = 2
          },

          Gnuplot::DataSet.new("x >= 400 && x <= 600 ? (-3*x)/2+900 : 1/0") { |ds|
            ds.with = "lines"
            ds.title = "(-3x)/2 + 900"
            ds.linewidth = 2
          }
        ]
      end
    end
    description = "Constant velocity of 1m/s for the first 300 seconds in the positive X direction. Constant velocity of 0m/s for the next 100 seconds. Finally, constant velocity of 1.5m/s in the negative direction for the next 200 seconds. Net displacement = 0"
    expect(1).to eq 1
  end

  it "page 64, question 4" do
    Gnuplot.open do|gp|
      Gnuplot::Plot.new(gp) do |plot|
        plot.xrange "[0:5]"
        plot.yrange "[-25:45]"
        plot.title "Figure P2.4"
        plot.xlabel "t(hours)"
        plot.ylabel "x(mi)"
        plot.data = [
          Gnuplot::DataSet.new("x >= 0 && x <= 1 ? 40 : 1/0") { |ds|
            ds.with = "lines"
            ds.title = "40"
            ds.linewidth = 2
          },

          Gnuplot::DataSet.new("x >= 1 && x <= 2 ? -60*x + 100 : 1/0") { |ds|
            ds.with = "lines"
            ds.title = "-60*x + 100"
            ds.linewidth = 2
          },

          Gnuplot::DataSet.new("x >= 2 && x <= 3 ? -20 : 1/0") { |ds|
            ds.with = "lines"
            ds.title = "-20"
            ds.linewidth = 2
          },

          Gnuplot::DataSet.new("x >= 3 && x <= 5 ? 10*x - 50 : 1/0") { |ds|
            ds.with = "lines"
            ds.title = "10*x - 50"
            ds.linewidth = 2
          }
        ]
      end
    end
    description = "Net displacement = x"
    expect(1).to eq 1
  end
end
=end


describe "Uniform motion" do
  it "[p64 q5] Suppose a car is moving with constant velocity along a straight road. Its position was xi = 15m at ti = 0.0s and is xf = 30m at tf = 3.0s. (A) What was its position at t = 1.5s? (B) What will its position be at t = 5.0s?" do
    x1 = 15
    x2 = 30
    t1 = 0
    t2 = 3
    v = uniformMotion(x1, x2, t1, t2)
    expect(uniformMotion(x1, nil, t1, 1.5, v)).to eq 22.5
    expect(uniformMotion(x1, nil, t1, 5.0, v)).to eq 40
  end

  it "[p64 q6] A car starts at the origin and moves with veolocity v = (10m/s, NE). How far from the origin will hte car be after traveling for 45 seconds?" do
    xi = 0
    v = 10
    ti = 0
    tf = 45
    expect(uniformMotion(xi, nil, ti, tf, v)).to eq 450
  end

  it "[p64 q7] Larry leaves home at 9:05AM and runs at a constant speed to the lamppost, shown in Figure P2.7. He reaches the lamppost at 9:07AM, immediately turns, and runs to the tree, again at constant speed. Larry arrives at the tree at 9:10AM. What is Larry's velocity during each of these two intervals?" do
    xi = 600
    xf = 200
    ti = 0
    tf = 2
    expect(uniformMotion(xi, xf, ti, tf, nil)).to eq -200
    xi = 200
    xf = 1200
    ti = 0
    tf = 3
    expect(uniformMotion(xi, xf, ti, tf, nil)).to eq 333.33
  end

  it "[p64 q8] Alan leaves Los Angeles at 8:00AM to drive to San Francisco, 400 mi away. He travels at a stead 50 mph. Beth leaves Los Angeles at 9:00AM and drives a steady 60mph. (A) Who gets to San Francisco first? (B) How long does the first to arrive have to wait for the second?" do
    xi = 0
    xf = 400
    tiAlan = 0
    tfAlan = nil
    vAlan = 50
    tiBeth = 1
    tfBeth = nil
    vBeth = 60
    tfAlan = uniformMotion(xi, xf, tiAlan, tfAlan, vAlan)
    tfBeth = uniformMotion(xi, xf, tiBeth, tfBeth, vBeth)
    firstArrival = tfAlan < tfBeth ? "Alan" : "Beth"
    expect(firstArrival).to eq "Beth"
    waitTime = delta(tfBeth, tfAlan).round(2)
    expect(waitTime).to eq 0.33
  end

  it "[p64 q9] Richard is driving home to visit his parents. 125 mi of the trip are on the interstate highway where the speed limit is 65mph. Normally Richard drives at the speed limit, but today he is running late and decides to take his chances by driving at 70mph. How many minutes does he save?" do
    xi = 0
    xf = 125
    ti = 0
    tf = nil
    v = 65
    usualTrip = uniformMotion(xi, xf, ti, tf, v)
    v = 70
    fastTrip = uniformMotion(xi, xf, ti, tf, v)
    deltaTHours = delta(usualTrip, fastTrip).abs
    expect(UnitConversions::hoursToMinutes(deltaTHours).round(2)).to eq 7.8
  end

  it "[p64 q10] In a 5.00km race, one runner runs at a steady 12.0 km/h and another runs at 14.5 km/h. How long does the faster runner have to wait at the finish line to see the slower runner cross?" do
    xi = 0
    xf = 5.00
    ti = 0
    tf_1 = nil
    v_1 = 12
    slowerRunnerTime = uniformMotion(xi, xf, ti, tf_1, v_1)
    tf_2 = nil
    v_2 = 14.5
    fasterRunnerTime = uniformMotion(xi, xf, ti, tf_2, v_2)
    deltaTHours = delta(slowerRunnerTime, fasterRunnerTime).abs
    expect(UnitConversions::hoursToMinutes(deltaTHours).round(2)).to eq 4.8
  end

  it "[p64 q11] In an 8.00km race, one runner runs at a steady 11.0km/h and another runs at 14.0km/h. How far from the finish line is the slower runner when the faster runner finishes the race?" do
    xi = 0
    xf = 8
    ti = 0
    tf_faster = nil
    v_faster = 14
    fasterFinishT = uniformMotion(xi, xf, ti, tf_faster, v_faster)
    xf_slower = nil
    v_slower = 11
    slowerPositionAtFasterFinish = uniformMotion(xi, xf_slower, ti, fasterFinishT, v_slower)
    expect((xf - slowerPositionAtFasterFinish).round(2)).to eq 1.73
  end

  it "[p64 q12] A bycyclist has the position-versus-time graph shown in Figure P2.12. What is the bicyclist's velocity at t = 10s, at t - 25s, and at t = 35s?" do
    Gnuplot.open do|gp|
      Gnuplot::Plot.new(gp) do |plot|
        plot.xrange "[0:40]"
        plot.yrange "[0:110]"
        plot.title "Figure P2.12"
        plot.xlabel "t(s)"
        plot.ylabel "x(m)"
        plot.data = [
          Gnuplot::DataSet.new("x >= 0 && x <= 20 ? (5 * x)/2 + 50 : 1/0") { |ds|
            ds.with = "lines"
            ds.title = "(5/2)*x + 50"
            ds.linewidth = 2
          },

          Gnuplot::DataSet.new("x >= 20 && x <= 30 ? 100 : 1/0") { |ds|
            ds.with = "lines"
            ds.title = "100"
            ds.linewidth = 2
          },

          Gnuplot::DataSet.new("x >= 30 && x <= 40 ? -10*x + 400 : 1/0") { |ds|
            ds.with = "lines"
            ds.title = "-10*x + 400"
            ds.linewidth = 2
          }
        ]
      end
    end
    description = "What are velocities at t = 10s, 25s, and 35s?"
    at10s = 5.0 / 2
    at25s = 0
    at35s = -10
    expect(at10s).to eq 2.5
    expect(at25s).to eq 0
    expect(at35s).to eq -10
  end

  it "Describing GnuPlot differences between mathematical syntax. Fractional slope values MUST be defined with float values otherwise an integer will be returned regardless of decimal quotient is ignored" do
    Gnuplot.open do|gp|
      Gnuplot::Plot.new(gp) do |plot|
        plot.xrange "[0:40]"
        plot.yrange "[0:110]"
        plot.title "Figure P2.12"
        plot.xlabel "t(s)"
        plot.ylabel "x(m)"
        plot.data = [
          Gnuplot::DataSet.new("x >= 0 && x <= 20 ? (5*x)/2 + 50 : 1/0") { |ds|
            ds.with = "lines"
            ds.title = "(5*x)/2 + 50"
            ds.linewidth = 2
          },

          Gnuplot::DataSet.new("x >= 0 && x <= 20 ? (5.0/2)*x + 50 : 1/0") { |ds|
            ds.with = "lines"
            ds.title = "(5.0/2)*x + 50"
            ds.linewidth = 2
          }
        ]
      end
    end
  end
end
