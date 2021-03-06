class TicTacToe
  def initialize(board=[" ", " ", " ", " ", " ", " ", " ", " ", " "])
    @board=board
  end
  
  def board
    @board
  end
  
 WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [2,4,6],
    [0,4,8]
    ]

def display_board()
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(num)
  input = num.strip
  int =  input.to_i
  input = int - 1
  return input
end

def move(index,char ='X')
  board[index] = char
  return board
end

def position_taken?(index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(index)
  if !position_taken?(index) && index >= 0 && index <=8
    return true
    else 
    return false
   end
end

#Executes a turn by prompting user for input and using the helper method current_player to determine whether the next move is 'X''s or 'O''s turn. If it's not a valid move, it will prompt the user to try again. 

def turn()
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
 if valid_move?(index)
   move(index,current_player())
   display_board()
   else 
   puts 'Please make sure square is not taken and is between 1-9'
   turn()
  end
end

def turn_count()
    count = 0
    board.each do |value|
    if value =="X" || value == "O"
    count +=1
  end
 end
 return count
end

#Method determines who's turn it is by testing whether the current turn count is an even or odd number using the remainder operator. 

def current_player()
  next_turn = turn_count()
  if next_turn % 2 == 0 
    return 'X'
  else 
    return 'O'
  end
end

#Method tests all possible tic tac toe winning combinations by using our winning combinations array and comparining them to see if one of the combinations has been played. 

def won?()
  WIN_COMBINATIONS.each do |combination|
    index_1 = combination[0]
    index_2 = combination[1]
    index_3 = combination[2]
    
    option_1 = board[index_1]
    option_2 = board[index_2]
    option_3 = board[index_3]

   if option_1 == option_2 && option_2 == option_3 && position_taken?(index_1)
     return combination
   end
  end 
return false
end

#Method tests whether the board is full of X's or O's by using the .all property on the board. 
def full?()
  board.all? { |value| value == 'X' || value == 'O'}
end

#Method uses previously defined methods to determine if there is a draw due to be board being full. 

def draw?()
  cond_1 = full?() == true;
  cond_2 = won?() == false;
  if cond_2 && cond_1 
    return true
    elsif !cond_1 && !cond_2
    return false
    else cond_2 == true
   return false
 end
end
  
#Method tests whether the game is over either because the game is a draw or because someone one. 
  def over?()
    if won?() || draw?()
      return true
    else 
      return false
    end
  end
  
  #Method returns the winning symbol by testing if there is a winner. If there is a winner, it sets the winning combination array to indexes. It then returns the first element of the winning array, which will return the winning character as either X or O. 
  
def winner()
  if won?()
    indexes = won?()
    return board[indexes[0]]
    else 
   return nil 
  end
end

#Method makes use of all previous methods to compile the tic tac toe game and congratulate the winner or state that there has been a draw. 

def play()
while !over?()
turn()
end
  if won?()
  puts "Congratulations #{winner()}!"
  elsif draw?()
  puts "Cat's Game!"
 end
end

end
