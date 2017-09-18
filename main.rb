require './connect_four'

def get_name
  puts "What is your name?"
  name = gets.chomp
  name
end

game = ConnectFour.new(get_name, get_name)
game.play
