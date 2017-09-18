require './connect_four'
require 'spec_helper'

describe ConnectFour do
  subject(:game) { ConnectFour.new("Guillermo", "Joe") }

  describe "#initialize" do
    it "should create a ConnectFour class" do
      expect(game).to be_instance_of ConnectFour
    end
    it "should create a Player class" do
      expect(game.player1).to be_instance_of Player
      expect(game.player2).to be_instance_of Player
    end
  end

  describe "create board" do
    it "should be an array of arrays" do
      expect(game.board).to be_instance_of Array
      expect(game.board[0]).to be_instance_of Array
    end
  end

  describe "winning games" do
    it "should find 4 in a row" do
      (2..5).each { |key| game.board[key][1] = "B"}
      expect(game.check_rows).to eql(true)
    end
    it "should find 4 in a column" do
      (0..3).each { |i| game.board[0][i] = "R" }
      expect(game.check_columns).to eql(true)
    end
    it "should find 4 in a diagonal" do
      game.board[1][1] = "B"
      game.board[2][2] = "B"
      game.board[3][3] = "B"
      game.board[4][4] = "B"
      expect(game.check_diagonals).to eql(true)
    end
    it "should return true when there are 4 in a row in row, column, or diagonal" do
      game.board[3][0] = "R"
      game.board[2][1] = "R"
      game.board[1][2] = "R"
      game.board[0][3] = "R"
      expect(game.won).to eql(true)
    end
  end

  describe "switching turns" do
    it "should switch between players" do
      expect(game.change_player).to eql(game.player2)
    end
  end

  describe "announce winners" do
    it "should announce a tie when out of turns" do
      game.turns = 0
      expect(game.announce_winner).to eql(puts "It's a tie!")
    end
    it "should announce when player 1 wins" do
      expect(game.announce_winner).to eql(puts "#{game.player1.name} won the game!")
    end
    it "should announce when player 2 wins" do
      game.change_player
      expect(game.announce_winner).to eql(puts "#{game.player2.name} won the game!")
    end
  end
end
