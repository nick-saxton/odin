class ConnectFour
    def initialize
        @columns = [[], [], [], [], [], [], []]
        @player_1_marker = "x"
        @player_2_marker = "o"
    end

    def check_for_diagonal_win(row, column, marker_to_check)
        diagonal1_to_check = []
        diagonal2_to_check = []

        (-3..3).each do |n|
            if !@columns[column + n][row + n].nil?
                diagonal1_to_check << @columns[column + n][row + n]
            end

            if !@columns[column + n][row - n].nil?
                diagonal2_to_check << @columns[column + n][row - n]
            end
        end

        if diagonal1_to_check.length >=4
            (diagonal1_to_check.length - 3).times do |n|
                return true if diagonal1_to_check[n..(n + 3)].all? { |marker| marker == marker_to_check }
            end
        end

        if diagonal2_to_check.length >= 4
            (diagonal2_to_check.length - 3).times do |n|
                return true if diagonal2_to_check[n..(n + 3)].all? { |marker| marker == marker_to_check }
            end
        end

        false
    end

    def check_for_horizontal_win(row, column, marker_to_check)
        row_to_check = []

        @columns.each do |column|
            row_to_check << column[row]
        end

        if row >= 3
            return true if row_to_check[(column - 3)..column].all? { |marker| marker == marker_to_check }
        end
        if row >= 2 and row <= 5
            return true if row_to_check[(column - 2)..(column + 1)].all? { |marker| marker == marker_to_check }
        end
        if row >= 1 and row <= 4
            return true if row_to_check[(column - 1)..(column + 2)].all? { |marker| marker == marker_to_check }
        end
        if row <= 3
            return true if row_to_check[column..(column + 3)].all? { |marker| marker == marker_to_check }
        end

        false
    end

    def check_for_tie
        return true if @columns.all? { |column| column.length == 6 }
        false
    end

    def check_for_vertical_win(row, column, marker_to_check)
        # Since this will be checked based on the last dropped
        # marker, we can rule out the first 3 dropped markers
        # in a column since they couldn't possibly make 4 in a row
        return false if row < 3

        column_to_check = @columns[column]
        marker_to_check = column_to_check[row]

        return true if column_to_check[(row - 3)..row].all? { |marker| marker == marker_to_check }

        false
    end

    def check_for_win(row, column)
        marker_to_check = @columns[row][column]

        return true if check_for_vertical_win(row, column, marker_to_check)
        return true if check_for_horizontal_win(row, column, marker_to_check)
        return true if check_for_diagonal_win(row, column, marker_to_check)
    end

    def drop(marker, column)
        if column < 0 or column > 6
            raise BadColumnError
        end

        if @columns[column].length == 6
            raise FullColumnError
        end

        @columns[column] << marker
    end

    def game_loop
        puts
        puts "Let's play a game of Connect Four!"
        puts
        puts "Take turns picking a column number to drop your marker into"
        puts "and the first to connect four in a row horizontally, vertically,"
        puts "or diagonally wins!"
        puts
        render_grid

        turn_counter = 0

        while true do
            begin
                if turn_counter % 2 == 0
                    current_marker = @player_1_marker
                else
                    current_marker = @player_2_marker
                end

                puts
                print "Choose a column (1-7) or hit Ctrl-c to quit: "

                column_selection = handle_input(gets.chomp)

                drop(current_marker, column_selection)
            rescue BadColumnError
                puts "The column number you've provided is invalid. Please try again."
                retry
            rescue Interrupt
                puts "Thanks for playing! Have a nice day."
                break
            end

            if check_for_win(@columns[column_selection].length - 1, column_selection)
                puts "#{} connected four in a row and wins!"
                break
            end

            if check_for_tie
                puts "It looks like it's ended in a tie! Thanks for playing."
                break
            end

            puts
            render_grid

            turn_counter += 1
        end
    end

    def handle_input input
        raise BadColumnError if !(input =~ /^[1-7]$/)
        input.to_i - 1
    end

    def render_grid
        puts "  1 2 3 4 5 6 7"
        6.times do |row|
            print " |"
            7.times do |column|
                print @columns[column][5 - row] || " "
                print "|"
            end
            print "\n"
        end
        puts " *-*-*-*-*-*-*-*"
        puts "/ \\           / \\"
    end

    class BadColumnError < StandardError; end
    class FullColumnError < BadColumnError; end
end