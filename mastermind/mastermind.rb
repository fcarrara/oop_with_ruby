require './peg'
require './board'

class Mastermind

  COLORS = { 1 => :red, 2 => :green, 3 => :yellow, 4 => :blue, 5 => :pink, 6 => :cyan, 7 => :white }

  def initialize(board)
    @board = board
    @current_row = -1
  end

  def play
    generate_pattern
    print_pattern
    
    while !game_over?
      print_board

      puts "Please choose up to #{@board.holes} colors from 1 to #{@board.number_of_pegs} comma separated (eg. 1,2,3):"
      1.upto(@board.number_of_pegs) { |i| print "#{i} = " + "  ".color(COLORS[i]) + "  " }
      print ": "
      input = gets.chomp
      
      while !input_valid?(input)
        print "Your input is invalid. Please try again! (eg. 1,2,3): "
        input = gets.chomp
      end

      color = input.split(",").map(&:to_i)
      color.each_with_index { |i,index| color[index] = COLORS[i] }

      @board.decoding_board[@current_row] = color
    end
  end

  def generate_pattern
    @board.holes.times do |i|
      code_peg = COLORS[rand(1..@board.number_of_pegs)]
      @board.pattern[i] = code_peg
    end
    @board.pattern
  end

  def print_pattern
    print "The pattern is: "
    @board.pattern.each { |val| print "  ".color(val) + " "}
  end

  def print_board
    puts ""
    line = "        " + "----" * @board.holes
    puts line
    board_size = @board.decoding_board.size - 1
    
    board_size.downto(0) do |i|
      print "%7s "%"#{i+1}. "

      @board.holes.times do |j|
        if j.nil?
          print "|  |" 
        else
          print "|" + "  ".color(@board.decoding_board[i][j]) + "|" 
        end
      end
      print "  "  

      @board.feedback_board[i].each { |j| print "|#{j}|" }
      print "\n"
      puts line
    end
    
    puts ""
  end

  def game_over?
    if @board.decoding_board[@current_row] == @board.pattern
      print_board
      puts "Game Over. You win! :D"
      print_pattern
      return true
    elsif @current_row == @board.rows - 1
      print_board
      puts "Game Over. You lost :("
      return true
    else
      provide_feedback
      @current_row += 1
      return false
    end
  end

  def input_valid?(input)
    begin
      input_arr = input.split(",").map(&:to_i)
      if input_arr.size > @board.holes || !input_arr.all? { |i| i <= @board.number_of_pegs }
        return false
      else
        return true
      end
    rescue
      return false
    end
  end

  def provide_feedback
    # Copy the array to a temp variable using dup method
    temp = @board.pattern.dup

    # Check first same color at same position (black)
    @board.decoding_board[@current_row].each_with_index do |i,index|
      if @board.pattern[index] == i
        temp[index] = 0
        @board.feedback_board[@current_row] << "B"
      end
    end

    # Check same color at different position (white)
    @board.decoding_board[@current_row].each_with_index do |i,index|
      if @board.pattern[index] != i
        if temp.include?(i)
          @board.feedback_board[@current_row] << "W"
          temp.delete_at(temp.index(i))
        end
      end
    end
  end
end

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
    else
      colorize(30)
    end
  end

end

#outputs color table to console, regular and bold modes
def colortable
  names = %w(black red green yellow blue pink cyan white default)
  fgcodes = (30..39).to_a - [38]

  s = ''
  reg  = "\e[%d;%dm%s\e[0m"
  bold = "\e[1;%d;%dm%s\e[0m"
  puts '                       color table with these background codes:'
  puts '          40       41       42       43       44       45       46       47       49'
  names.zip(fgcodes).each {|name,fg|
    s = "#{fg}"
    puts "%7s "%name + "#{reg}  #{bold}   "*9 % [fg,40,s,fg,40,s,  fg,41,s,fg,41,s,  fg,42,s,fg,42,s,  fg,43,s,fg,43,s,  
      fg,44,s,fg,44,s,  fg,45,s,fg,45,s,  fg,46,s,fg,46,s,  fg,47,s,fg,47,s,  fg,49,s,fg,49,s ]
  }
end

print "Please select difficulty (1 - Easy, 2 - Medium, 3 - Hard): "
difficulty = gets.chomp
board = Board.new(difficulty)
game = Mastermind.new(board)
game.play

# colortable