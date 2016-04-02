require './player'

class TicTacToe

  WIN_CASES = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],
               [2,4,6],[0,3,6],[1,4,7],[2,6,8]]

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Array.new(9, " ")
    @current_player = ""
    @available_options = []
  end

  def play  
    puts ""
    puts "Game on!"
    puts ""

    print_board
    
    # Game starts!
    while !win_game?
      if !board_full?
        @current_player = @current_player == @player1 ? @player2 : @player1
        puts "#{@current_player.name} please select an option: "
        print_available_options
        option = gets.chomp
        while !option_valid?(option.to_i)
          print "The option selected is not valid. Try again! : "
          option = gets.chomp
        end
        update_board(option.to_i)
        print_board
      else
        puts "Game over. It'a a tie!"
        return
      end
    end
    puts "Game over. #{@current_player.name} wins!"
  end

  def print_board
    puts ""
    puts "    Tic Tac Toe!"
    puts ""
    puts "     |" + "  ".color(@board[0]) + "|" + "  ".color(@board[1]) + "|" + "  ".color(@board[2]) + "|"
    puts "     ----------"
    puts "     |" + "  ".color(@board[3]) + "|" + "  ".color(@board[4]) + "|" + "  ".color(@board[5]) + "|"
    puts "     ----------"
    puts "     |" + "  ".color(@board[6]) + "|" + "  ".color(@board[7]) + "|" + "  ".color(@board[8]) + "|"
    puts ""
  end

  def update_board(option)
    @board[option - 1] = @current_player.color
  end

  def print_available_options
    @available_options = @board.each_index.select { |n| @board[n] == " " }
    @available_options.each { |i| print "#{i + 1} " }
    print ": "
  end

  def option_valid?(option)
    @available_options.include?(option - 1)  
  end

  def win_game?
    return if @current_player == ""
    WIN_CASES.each do |i|
      if [@board[i[0]],@board[i[1]],@board[i[2]]].all? { |i| i == @current_player.color }
        return true
      end
    end
    false
  end

  def board_full?
    @board.all? { |n| n != " " }
  end
  
end