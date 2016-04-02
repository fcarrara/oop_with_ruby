require './board'
require './mastermind2.rb'

puts ""
puts "*******   Welcome to MasterMind!   *******"
puts ""
print "Please select the codemaker: 1. Computer  2. Human: "
human_codemaker = gets.chomp
human_codemaker = human_codemaker == "1" ? false : true
print "Please select difficulty (1 - Easy, 2 - Medium, 3 - Hard): "
difficulty = gets.chomp
puts ""
board = Board.new(difficulty)
game = Mastermind.new(board,human_codemaker)
game.play