class Peg

  attr_reader :color

  COLORS = { 1 => :red, 2 => :green, 3 => :yellow, 4 => :blue, 5 => :pink, 6 => :cyan, 7 => :white }

  def initialize(number)
    @color = COLORS[number]
    # # Calling the new String method that colorize the string
    # @color = "  ".color(@color_str)
  end

end