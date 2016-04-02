require './tic_tac_toe'
require './string'

COLORS = { 1 => :red, 2 => :green, 3 => :yellow, 4 => :blue, 5 => :pink, 6 => :cyan, 7 => :white }

# Print the available colors on the screen
def print_colors
  1.upto(COLORS.size) { |i| print "#{i} = " + "  ".color(COLORS[i]) + "  " }
  print ": "
end

puts "******  Welcome to Tic Tac Toe!  ******"
puts ""
print "Insert player 1 name: "
player1_name = gets.chomp
puts "#{player1_name}, with which color would you like to play? "
print_colors
player1_color = gets.chomp
puts ""
print "Insert player 2 name: "
player2_name = gets.chomp
puts "#{player2_name}, with which color would you like to play? "
print_colors
player2_color = gets.chomp
 
while player2_color == player1_color
  puts ""
  puts "The color selected has been previously selected by #{player1_name}. Try again!"
  print_colors
  player2_color = gets.chomp
end

player1 = Player.new(player1_name, COLORS[player1_color.to_i])
player2 = Player.new(player2_name, COLORS[player2_color.to_i])

game = TicTacToe.new(player1, player2)
game.play