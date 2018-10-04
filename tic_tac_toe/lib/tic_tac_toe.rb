class Game
  COLUMN_CONVERSION = {"A": 0, "B": 1, "C": 2}

  def initialize
    @grid = Grid.new
    @player1 = Player.new('x')
    @player2 = Player.new('o')
    @turn_counter = 0
  end

  def start
    puts "*********************************************"
    puts "* Welcome to Ruby Tic-tac-toe!              *"
    puts "* - Player 1 will be x                      *"
    puts "* - Player 2 will be o                      *"
    puts "* Please select a spot on the grid to mark  *"
    puts "* by specifying the column (e.g. A)         *"
    puts "* immediately followed by the row (e.g. 1). *"
    puts "*********************************************"

    game_loop()
  end

  def game_loop
    loop do
      # Draw the current grid
      @grid.draw()

      # Determine the current player
      current_player = @turn_counter % 2 == 0 ? @player1 : @player2

      # Get user input and then mark the indicated spot
      # If successful, move to the next turn
      begin
        row, column = get_input()
        current_player.mark(@grid, row, column)
      rescue ArgumentError
        puts
        puts "*** Invalid input! Please enter a column (A-C) immediately followed by a row (1-3). ***"
        next
      rescue IndexError
        puts
        puts "*** That space has already been marked. Please try again. ***"
        next
      rescue Interrupt
        puts
        puts "Game ended. Have a nice day!"
        break
      else
        @turn_counter += 1
      end

      # Check for a winner
      break if current_player.win?(@grid)
    end
  end

  # Add method to get input and return symbol and integer
  def get_input
    print "Please choose a space to mark (or Ctrl-C to quit): "

    space_to_mark = gets.chomp.upcase()

    validate_input(space_to_mark)
    convert_input(space_to_mark)
  end

  def validate_input input
    # Throw an error if the input is bad
    raise ArgumentError if /^[A-C][1-3]$/.match(input).nil?
  end

  def convert_input input
    split_input = input.split("")

    row = split_input[1].to_i - 1
    column = COLUMN_CONVERSION[split_input[0].to_sym]

    return row, column
  end

  class Grid
    def initialize
      @grid = [[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]]
    end

    def draw
      puts
      puts "    A   B   C  "
      puts "  *-----------*"
      @grid.each_with_index do |row, index|
        puts "#{index + 1} | #{row[0]} | #{row[1]} | #{row[2]} |"
        if index < 2
          puts "  -------------"
        end
      end
      puts "  *-----------*"
      puts
    end

    def mark(row, column, marker)
      raise IndexError if row < 0 or row > 2
      raise IndexError if column < 0 or column > 2
      raise IndexError if @grid[row][column].strip.length != 0

      @grid[row][column] = marker
    end

    def win?(marker)
      if (@grid[0].all? {|i| i == marker} or @grid[1].all? {|i| i == marker} or @grid[2].all? {|i| i == marker}) or
         (@grid[0][0] == marker and @grid[1][0] == marker and @grid[2][0] == marker) or
         (@grid[0][1] == marker and @grid[1][1] == marker and @grid[2][1] == marker) or
         (@grid[0][2] == marker and @grid[1][2] == marker and @grid[2][2] == marker) or
         (@grid[0][0] == marker and @grid[1][1] == marker and @grid[2][2] == marker) or
         (@grid[0][2] == marker and @grid[1][1] == marker and @grid[2][0] == marker)
        return true
      end
      false
    end
  end

  class Player
    def initialize(marker)
      @marker = marker
    end

    def mark(grid, row, column)
      grid.mark(row, column, @marker)
    end

    def win?(grid)
      grid.win?(@marker)
    end
  end
end

game = Game.new
game.start