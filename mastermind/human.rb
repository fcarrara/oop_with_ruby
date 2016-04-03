class Human < Codemaker

  def generate_pattern
    puts "Please enter #{@board.holes} colors separated by comma (eg. 1,2,3): "
    print_colors
    input_colors = get_and_validate_input
    @board.holes.times  { |i| @board.pattern[i] = COLORS[input_colors[i]] }
    
    # Clean the screen to hide the pattern
    system "clear" or system "cls"
    system "clear" or system "cls"
  end

  def play
    puts "Please choose up to #{@board.holes} colors from 1 to #{@board.number_of_pegs} separated by comma (eg. 1,2,3):"
    print_colors
    
    input_colors = get_and_validate_input
    input_colors.each_with_index { |i,index| input_colors[index] = COLORS[i] }
    @board.decoding_board[@@current_row] = input_colors
  end

  private 
  
    # Print the available colors on the screen
    def print_colors
      1.upto(@board.number_of_pegs) { |i| print "#{i} = " + "  ".color(COLORS[i]) + "  " }
        print ": "
    end

    def get_and_validate_input
      input = gets.chomp

      while !input_valid?(input)
        print "Your input is invalid. Please try again! (eg. 1,2,3): "
        input = gets.chomp
      end

      input.split(",").map(&:to_i)
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

end