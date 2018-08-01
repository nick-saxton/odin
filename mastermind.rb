class Mastermind
  def initialize
    @board = Board.new
    @codebreaker = false
  end

  def play
    # Determine if user will play as the codemaker or codebreaker
    @codebreaker = choose_role

    welcome_message

    @board.create_code if not @codebreaker

    12.times do |i|
      puts 
      puts "Round #{i + 1}"
      puts "*" * "Round #{i + 1}".length
      if @codebreaker
        # Begin the guessing if the user is the codebreaker
        begin
          if @board.check_guess(guess)
            puts "Congratulations! You've cracked the code and mastered the codemaker!!!"
            puts
            break
          end
        rescue InputError
          puts
          puts "*** Invalid guess! Please enter four colors from the given options separated by spaces. ***"
          redo
        rescue Interrupt
          puts
          puts "Thanks for playing! See you next time!"
          puts
          break
        end
      else
        if @board.check_guess(computer_guess)
          puts "The computer has broken your code... You lose!"
          puts
          break
        end
      end
    end
  end

  def choose_role
    begin
      print "Would you like to play as the codemaker (1) or the codebreaker (2): "
      choice = gets.chomp
      case choice.to_i
      when 1
        return false
      when 2
        return true
      else
        raise InputError
      end
    rescue InputError
      puts "Please enter either 1 or 2."
      retry
    end
  end

  def welcome_message
    puts "*-------------------------------------------------*"
    puts "| Welcome to Mastermind - the code-breaking game! |"
    puts "|                                                 |"
    if @codebreaker
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
    else
      puts "|  You are the codemaker! It is your job to craft |"
      puts "| a tricky pattern of colors to try to make it as |"
      puts "| hard as possible for the computer to break your |"
      puts "|                code. Good luck!                 |"
    end
    puts "*-------------------------------------------------*"
  end

  def guess()
    puts "Please guess the code by entering four colors separated by spaces"
    puts "(red, orange, yellow, green, blue, purple):"
    guess = @board.validate_input(gets.chomp.split().map { |color| color.downcase.to_sym })
    puts
    guess
  end

  def computer_guess
    guess = [Board::COLORS.sample, Board::COLORS.sample, Board::COLORS.sample, Board::COLORS.sample]
    puts "The computer has guessed #{guess.map { |color| color.to_s }}"
    guess
  end

  class Board
    attr_reader :key_pegs

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

    def create_code
      begin
        puts "Please create the code by entering four colors separated by spaces"
        puts "(red, orange, yellow, green, blue, purple):"
        @secret_code = validate_input(gets.chomp.split().map { |color| color.downcase.to_sym })
      rescue InputError
        puts "*** Invalid input! Please try again. ***"
        retry
      end
    end

    def validate_input(guess)
      if guess.length != 4
        raise InputError
      end
      guess.each do |color|
        if COLORS.include? color == false
          raise InputError
        end
      end
      guess
    end
  end

  class InputError < StandardError; end
end

game = Mastermind.new
game.play