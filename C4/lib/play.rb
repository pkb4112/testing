require_relative "c4"
require "matrix"

#Retrieves player names from the users, the argument simply allows for input of player "1" or "2"

def create_player(player_num)
    puts "Enter Player Name:"
    Player.new(gets.chomp,player_num)
end

def create_gameboard
  GameBoard.new(Array.new(6){Array.new(7){'*'}})
end

def show_gameboard(gameboard)
  system "clear"
  6.times do |x|
    print gameboard.matrix[x]
    puts""
  end
end

#The player inputs an x,y location for the board provided as a parameter, it is verified, then returned if valid
def choose_location_on(gameboard_instance)
  location = [] #must be out of bounds
  until gameboard_instance.check_location(location)
    input_loc = gets.chomp
    location[0] = input_loc.match(/(^\d)/)[0].to_i
    location[1] = input_loc.match(/(\d$)/)[0].to_i
    unless gameboard_instance.check_location(location)
      puts "That location is out of bounds, has already been selected, or has no piece under it"
    end
  end
  return location 
end

#Gameplay Loop
def game_loop
  player_1 = create_player(1)
  player_2 = create_player(2)
  game = create_gameboard
  turns = 0
  curr_player = player_1
  until player_1.win?(game) || player_2.win?(game) || turns == 42
    show_gameboard(game)
    puts ""
    if curr_player == player_1
      puts "#{player_1.name} choose a location on the board in x,y format"
      game.place_piece(choose_location_on(game),player_1)
      curr_player = player_2
    else
      puts "#{player_2.name} choose a location on the board in x,y format"
      game.place_piece(choose_location_on(game),player_2)
      curr_player = player_1
    end
    turns+=1
  end
  if turns >=42 
    show_gameboard(game)
    puts "Game Over - Tie"
  elsif player_1.win?(game)
    show_gameboard(game)
    puts "#{player_1.name} Wins!"
  elsif player_2.win?(game) 
    show_gameboard(game)
    puts "#{player_2.name} Wins!"
  end
  return
end

game_loop