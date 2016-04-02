class Board

  attr_reader :number_of_pegs, :decoding_board, :feedback_board, :holes, :rows
  attr_accessor :pattern

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
      @number_of_pegs = 7
      @rows = 12
      @holes = 5
    end
    @decoding_board = Array.new(@rows) { Array.new(@holes) }
    @feedback_board = Array.new(@rows) { Array.new }
    @pattern = Array.new(@holes)
  end
end
