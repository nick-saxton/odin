class Mastermind
  def initialize
    @board = Board.new
  end

  def play
    welcome_message

    12.times do |i|
      begin
        if @board.check_guess(guess(i + 1))
          puts "Congratulations! You've cracked the code and mastered the codemaker!!!"
          puts
          break
        end
      rescue GuessError
        puts
        puts "*** Invalid guess! Please enter four colors from the given options separated by spaces. ***"
        redo
      rescue Interrupt
        puts
        puts "Thanks for playing! See you next time!"
        puts
        break
      end
    end
  end

  def welcome_message
    puts "*-------------------------------------------------*"
    puts "| Welcome to Mastermind - the code-breaking game! |"
    puts "|                                                 |"
    puts "|  A secret code consisting of a pattern of four  |"
    puts "|   colors has been selected. You will have 12    |"
    puts "|   rounds to try to correctly guess the code.    |"
    puts "|  Following each round of guessing you will be   |"
    puts "|     awarded anywhere from 0 to 4 key pegs.      |"
    puts "|  A black key peg means a part of your guess is  |"
    puts "|   correct in both color and position, while a   |"
    puts "| white key peg indicates you've guessed a color  |"
    puts "|      correctly but in the wrong position.       |"
    puts "|                  Good luck!                     |"
    puts "*-------------------------------------------------*"
  end

  def guess(round)
    puts 
    puts "Round #{round}"
    puts "*" * "Round #{round}".length
    puts "Please guess the code by entering four colors separated by spaces"
    puts "(red, orange, yellow, green, blue, purple):"
    guess = validate_guess(gets.chomp.split().map { |color| color.downcase.to_sym })
    puts
    guess
  end

  def validate_guess(guess)
    if guess.length != 4
      raise GuessError
    end
    guess.each do |color|
      if Board::COLORS.include? color == false
        raise GuessError
      end
    end
    guess
  end

  class Board
    COLORS = [:red, :orange, :yellow, :green, :blue, :purple]

    def initialize
      @secret_code = [COLORS.sample, COLORS.sample, COLORS.sample, COLORS.sample]
      @key_pegs = []
    end

    def check_guess(guess)
      @key_pegs = []
      checked_colors = []

      # Check for exactly correct guess
      guess.each_with_index do |color, index|
        if color == @secret_code[index]
          checked_colors << color
          @key_pegs << :black
        end
      end

      # Check for semi-correct guesses
      guess.each do |color|
        if @secret_code.include? color and not checked_colors.include? color
          checked_colors << color
          @key_pegs << :white
        end
      end

      # Check for a cracked code
      if @key_pegs.length == 4 and @key_pegs.all? { |key_peg| key_peg == :black }
        return true
      end

      print "Key pegs for guess: "
      @key_pegs.each do |key_peg|
        print "#{key_peg} "
      end
      puts

      false
    end
  end

  class GuessError < StandardError; end
end

game = Mastermind.new
game.play