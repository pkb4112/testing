require "matrix"

class GameBoard
  attr_accessor :matrix

  def initialize(matrix)
    @matrix = matrix
  end

#Checks to ensure the x,y location in question is both within the gameboard bounds and hasn't already been played
  def check_location(location)
    
    begin
      if !(@matrix[location[1]][location[0]] == '*')  # matrix[row,col] (opposite of x,y)
        return false
      elsif location[1]<5 && (@matrix[location[1]+1][location[0]] == '*') #can't defy gravity
        return false
      else
        return true
      end
    rescue
      return false
    end
  end 

  def place_piece(location,player)
    if player.player_num == 1  
      @matrix[location[1]][location[0]] = 'X' # matrix[row,col] (opposite of x,y)
      player.pieces << [location[0],location[1]]
    elsif player.player_num == 2 
      @matrix[location[1]][location[0]] = 'O'
       player.pieces << [location[0],location[1]]
    end
  end
end #GameBoard end

class Player
  attr_accessor :pieces
  attr_reader :name, :player_num

  def initialize(name='Unkown',x=1)
    @player_num = x
    @name = name
    @pieces = []
  end

  def win?(gameboard)
    if self.pieces.size<4 
      return false
    end
    begin
      first_piece = self.pieces.first #[X,Y]
      marker = gameboard.matrix[first_piece[1]][first_piece[0]] #X or O
      self.pieces.each do |piece|
        4.times do |i| # Horizontal Win
          begin
             if !(gameboard.matrix[piece[1]][(piece[0]+i)] == marker)  #need to catch out of bounds exception
               break
             elsif i == 3
              return true 
            end
          rescue
            break
          end
        end
        4.times do |i| #Vertical Win
          begin
            if !(gameboard.matrix[(piece[1]+i)][piece[0]] == marker)
             break
            elsif i == 3

              return true 
            end
        rescue
          break
        end
        end
        4.times do |i| #Diagonal right
          begin
            if !(gameboard.matrix[(piece[1]-i)][(piece[0]+i)] == marker)
              break
            elsif i == 3
              return true 
            end
          rescue
            break
          end
        end
        4.times do |i| #Diagonal left
          begin
            if !(gameboard.matrix[(piece[1]-i)][(piece[0]-i)] == marker)
              break
            elsif i == 3
              return true 
            end
        rescue
          break
        end
      end
    end

    rescue
    puts "rescue"   
    sleep(1)    #If the above code begins looking at values outside the gameboard
      return false
    end
  return false
  end 
end #class end

