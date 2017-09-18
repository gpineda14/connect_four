class ConnectFour
  require './player'
  attr_accessor :board, :player1, :player2, :turns
  def initialize(player1="player1", player2="player2")
    @board = create_board
    @player1 = Player.new(player1, "R")
    @player2 = Player.new(player2, "B")
    @curr_player = @player1
    @turns = 42
  end

  # show user the instructions
  def instructions
    puts "Welcome to Connect Four!"
    puts "The first to get four in a row, column, or diagonal wins!"
    puts "Good luck!"
  end

  # begin the game
  def play
    instructions
    display_board
    until won || @turns == 0
      puts "#{@curr_player.name}, it is your turn."
      enter_move(@curr_player.color)
      display_board
      @turns -= 1
      break if won
      change_player
    end
    announce_winner
  end

  # create an array with arrays as values
  def create_board
    cols = Array.new(7) { Array.new(6, 0) }
    cols
  end

  # display the connect four gameboard
  def display_board
    str = ""
    5.downto(0) do |i|
      @board.each {|row| str += row[i].to_s + " "}
      str += "\n"
    end
    puts str
  end

  # prompts user to enter a move
  def enter_move(color)
    puts "Select a column (1-7): "
    move = gets.chomp.upcase
    move = move.to_i - 1
    until move >= 0 && move <= 6  && @board[move].include?(0)
      puts "Not a column"
      move = gets.chomp.upcase
      move = move.to_i - 1
    end
    input_move(move, color)
  end

  # updates the board by adding move to the board
  def input_move(move, color)
    move = move.to_i
    index = 0
    until @board[move][index] == 0
      index += 1
    end
    @board[move][index] = color
  end

  # check if there are four in a row, column, or diagonal
  def won
    if check_rows || check_columns || check_diagonals
      return true
    else
      return false
    end
  end

  # announces the winner when there are four consecutive markers
  def announce_winner
    puts "It's a tie!" if @turns == 0
    puts @curr_player == @player1 ? "#{@player1.name} won the game!" : "#{@player2.name} won the game!"
  end

  # switches players for their turns
  def change_player
    @curr_player == @player1 ? @curr_player = @player2 : @curr_player = @player1
  end

  # check if there are 4 consecutive markers in a row
  def check_rows
    0.upto(5) do |i|
      str = ""
      0.upto(6) do |j|
        str += @board[j][i].to_s
      end
      if str.match(/RRRR|BBBB/) != nil
        return true
      end
    end
    return false
  end

  # check if there are 4 consecutive markers in a column
  def check_columns
    @board.each do |column|
      column = column.join("")
      if column.match(/RRRR|BBBB/) != nil
        @winning_score = column
        return true
      end
    end
    return false
  end

  # check if there are 4 consecutive in a diagonal
  def check_diagonals
    0.upto(2) do |i|
      0.upto(3) do |j|
        if (@board[j][i].to_s + @board[j + 1][i + 1].to_s + @board[j + 2][i + 2].to_s + @board[j + 3][i + 3].to_s).match(/RRRR|BBBB/) != nil
          return true
        end
      end
      3.upto(6) do |j|
        if (@board[j][i].to_s + @board[j - 1][i + 1].to_s + @board[j - 2][i + 2].to_s + @board[j - 3][i + 3].to_s).match(/RRRR|BBBB/) != nil
          return true
        end
      end
    end
    return false
  end

end
