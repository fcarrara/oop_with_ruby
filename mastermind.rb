class Mastermind

  def initialize(board)
    @board = board
  end

  def play
    print create_pattern
  end

  def create_pattern
    @board.holes.times do |i|
      @board.pattern[i] = CodePeg.new(rand(@board.number_of_pegs))
    end
    @board.pattern
  end
end

class Board

  attr_reader :number_of_pegs, :pattern, :decoding_board, :feedback_board, :holes

  def initialize(difficulty)
    case difficulty.to_i
    when 1
      @number_of_pegs = 6
      @rows = 10
      @holes = 3
    when 2
      @number_of_pegs = 6
      @rows = 10
      @holes = 4
    else
      @number_of_pegs = 8
      @rows = 12
      @holes = 5
    end
    @decoding_board = Array.new(@rows, Array.new(@holes, " "))
    @feedback_board = Array.new(@rows, Array.new(@holes, " "))
    @pattern = Array.new(@holes," ")
  end
end


class CodePeg

  attr_reader :color

  COLORS = { 0 => :blue, 1 => :yellow, 2 => :red, 3 => :green, 4 => :orange, 5 => :pink }

  def initialize(number)
    @color = COLORS[number]
  end

end

# Extending String class to print string 
# in different background colors
class String

  def colorize(color)
    "\e[#{color}m#{self}\e[0m"
  end

  def red
    colorize(41)
  end

  def green
    colorize(42)
  end

  def yellow
    colorize(43)
  end

  def blue
    colorize(44)
  end

  def pink
    colorize(45)
  end

  def cyan
    colorize(46)
  end

  def white
    colorize(47)
  end
end

print "Please select difficulty (1 - Easy, 2 - Medium, 3 - Hard): "
difficulty = gets.chomp
board = Board.new(difficulty)
game = Mastermind.new(board)
print game.play