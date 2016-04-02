# Extending String class to print string 
# in different background colors
class String

  def colorize(color)
    "\e[#{color}m#{self}\e[0m"
  end

  def color(color)
    case color
    when :red
      colorize(41)
    when :green
      colorize(42)
    when :yellow
      colorize(43)
    when :blue
      colorize(44)
    when :pink
      colorize(45)
    when :cyan
      colorize(46)
    when :white
      colorize(47)
    # black
    else
      colorize(30)
    end
  end

end