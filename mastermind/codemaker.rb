require './board'
require './string'

class Codemaker

  COLORS = { 1 => :red, 2 => :green, 3 => :yellow, 4 => :blue, 5 => :pink, 6 => :cyan, 7 => :white }

  def initialize(board)
    @board = board
    @@current_row = -1
    @@black_matches = {}
    @@white_matches = []
  end

  def provide_feedback
    # Copy the array to a temp variable using dup method
    temp = @board.pattern.dup
    @@black_matches = {}
    @@white_matches = []

    # Check first same color at same position (black)
    @board.decoding_board[@@current_row].each_with_index do |i,index|
      if @board.pattern[index] == i
        temp[index] = 0
        @board.feedback_board[@@current_row] << "B"
        @@black_matches[index] = i
      end
    end

    # Check same color at different position (white)
    @board.decoding_board[@@current_row].each_with_index do |i,index|
      if @board.pattern[index] != i
        if temp.include?(i)
          @board.feedback_board[@@current_row] << "W"
          temp.delete_at(temp.index(i))
          @@white_matches << i
        end
      end
    end
    @@current_row += 1
    puts "CURRENT ROW = #{@@current_row}"
  end

  def print_pattern
    print "The pattern is: "
    @board.pattern.each { |val| print "  ".color(val) + " "}
    puts ""
  end

  # Print the main decoding board and feedback board on the screen
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
    if @board.decoding_board[@@current_row] == @board.pattern
      print_board
      puts "Game Over. You win! :D"
      true
    elsif @@current_row == @board.rows - 1
      print_board
      puts "Game Over. You lost :("
      true
    else
      false
    end
  end
end