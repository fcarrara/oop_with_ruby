require './spec_helper'
require '../player'
require '../tic_tac_toe'


describe TicTacToe do
  
  let(:player1) { Player.new("Fab", :red) }
  let(:player2) { Player.new("Elya", :blue) }
  let(:game) { TicTacToe.new(player1, player2) }

  context "#play" do
    it "returns Player 1 won" do
      allow(game).to receive(:gets).and_return("1\n", "4\,", "2\n", "5\n", "3\n")
      expect(game.play).to eq("Game over. #{player1.name} wins!")
    end

    it "returns tie game" do
      allow(game).to receive(:gets).and_return("1\n", "2\,", "3\n", "4\n", "5\n", 
                                               "7\n", "6\n", "9\n", "8\n")
      expect(game.play).to eq("Game over. It'a a tie!")
    end
  end

  context "#win_game?" do

    before :each do
      game.current_player = player1
    end

    it "returns true if top row is complete with same color" do
      game.board[0] = :red
      game.board[1] = :red
      game.board[2] = :red
      expect(game.win_game?).to be true
    end

    it "returns true if middle row is complete with same color" do
      game.board[3] = :red
      game.board[4] = :red
      game.board[5] = :red
      expect(game.win_game?).to be true
    end

    it "returns true if bottom row is complete with same color" do
      game.board[6] = :red
      game.board[7] = :red
      game.board[8] = :red
      expect(game.win_game?).to be true
    end

    it "returns true if left column is complete with same color" do
      game.board[0] = :red
      game.board[3] = :red
      game.board[6] = :red
      expect(game.win_game?).to be true
    end

    it "returns true if middle column is complete with same color" do
      game.board[1] = :red
      game.board[4] = :red
      game.board[7] = :red
      expect(game.win_game?).to be true
    end

    it "returns true if right column is complete with same color" do
      game.board[2] = :red
      game.board[5] = :red
      game.board[8] = :red
      expect(game.win_game?).to be true
    end

    it "returns true if first diagonal is complete with same color" do
      game.board[0] = :red
      game.board[4] = :red
      game.board[8] = :red
      expect(game.win_game?).to be true
    end

    it "returns true if second diagonal is complete with same color" do
      game.board[2] = :red
      game.board[4] = :red
      game.board[6] = :red
      expect(game.win_game?).to be true
    end

    it "returns false if any row or column is complete with different color" do
      game.board[0] = :red
      game.board[1] = :blue
      game.board[2] = :red
      expect(game.win_game?).to be false
    end
  end
end