require './board'
require './string'

class Mastermind

  COLORS = { 1 => :red, 2 => :green, 3 => :yellow, 4 => :blue, 5 => :pink, 6 => :cyan, 7 => :white }

  def initialize(board,human_codemaker)
    @board = board
    @current_row = -1
    @human_codemaker = human_codemaker
    @black_matches = {}
    @white_matches = []
  end

  def human_codemaker?
    @human_codemaker
  end

  def play
    generate_pattern
    
    while !game_over?
      print_board

      if human_codemaker?
        computer_play
      else
        puts "Please choose up to #{@board.holes} colors from 1 to #{@board.number_of_pegs} separated by comma (eg. 1,2,3):"
        print_colors
        
        input_colors = get_and_validate_input
        input_colors.each_with_index { |i,index| input_colors[index] = COLORS[i] }

        @board.decoding_board[@current_row] = input_colors
      end
    end
    puts ""
    print_pattern
    puts ""
  end

  def get_and_validate_input
    input = gets.chomp

    while !input_valid?(input)
      print "Your input is invalid. Please try again! (eg. 1,2,3): "
      input = gets.chomp
    end

    input.split(",").map(&:to_i)
  end

  def generate_pattern
    if human_codemaker?
      puts "Please enter #{@board.holes} colors separated by comma (eg. 1,2,3): "
      print_colors
      input_colors = get_and_validate_input
      @board.holes.times  { |i| @board.pattern[i] = COLORS[input_colors[i]] }
      system "clear" or system "cls"
      system "clear" or system "cls"
    else
      @board.holes.times { |i| @board.pattern[i] = COLORS[rand(1..@board.number_of_pegs)] }
    end
    @board.pattern
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

  # Print the available colors on the screen
  def print_colors
    1.upto(@board.number_of_pegs) { |i| print "#{i} = " + "  ".color(COLORS[i]) + "  " }
      print ": "
  end

  def game_over?
    if @board.decoding_board[@current_row] == @board.pattern
      print_board
      puts "Game Over. You win! :D"
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

  # Validate that the combination of colors selected is correct
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
    @black_matches = {}
    @white_matches = []

    # Check first same color at same position (black)
    @board.decoding_board[@current_row].each_with_index do |i,index|
      if @board.pattern[index] == i
        temp[index] = 0
        @board.feedback_board[@current_row] << "B"
        @black_matches[index] = i
      end
    end

    # Check same color at different position (white)
    @board.decoding_board[@current_row].each_with_index do |i,index|
      if @board.pattern[index] != i
        if temp.include?(i)
          @board.feedback_board[@current_row] << "W"
          temp.delete_at(temp.index(i))
          @white_matches << i
        end
      end
    end
  end

  # Computer AI
  def computer_play

    # Any black feedback from previous guess?
    if @black_matches.size > 0
      @black_matches.each do |key,value|
        @board.decoding_board[@current_row][key] = value
      end
    end
   
    # Any white feedback from previous guess?
    if @white_matches.size > 0
      # Assign the colors to a temporary list 
      temp = @white_matches.dup
      @white_matches.size.times do |i|
        color = temp[rand(temp.size)]
        #First nil from board we assign a random color found in previous guess
        @board.decoding_board[@current_row][@board.decoding_board[@current_row].index(nil)] = color
        # Delete the color from the temporary list to avoid assigning it again
        temp.slice!(temp.index(color))
      end
    end

    # Complete the rest with random colors
    @board.holes.times do |i| 
      if @board.decoding_board[@current_row][i].nil? 
        @board.decoding_board[@current_row][i] = COLORS[rand(1..@board.number_of_pegs)]
      end 
    end
  end

end