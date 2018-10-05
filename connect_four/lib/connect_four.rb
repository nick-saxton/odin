class ConnectFour
    def initialize
        @columns = [[], [], [], [], [], [], []]
        @player_1_marker = "\u26AA"
        @player_2_marker = "\u26AB"
    end

    def check_for_win(row, column)
        marker_to_check = @columns[row][column]

        return true if check_for_vertical_win(row, column, marker_to_check)
        return true if check_for_horizontal_win(row, column, marker_to_check)
        return true if check_for_diagonal_win(row, column, marker_to_check)
    end

    def check_for_diagonal_win(row, column, marker_to_check)
        diagonal1_to_check = []
        diagonal2_to_check = []

        (-3..3).each do |n|
            if !@columns[row + n][column + n].nil?
                diagonal1_to_check << @columns[row + n][column + n]
            end

            if n <= 0
                if !@columns[row + n][column - n].nil?
                    diagonal2_to_check << @columns[row + n][column - n]
                end
            else
                if !@columns[row - n][column + n].nil?
                    diagonal2_to_check << @columns[row - n][column + n]
                end
            end
        end
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

    def drop(marker, column)
        if column < 0 or column > 6
            raise BadColumnError
        end

        if @columns[column].length == 6
            raise FullColumnError
        end

        @columns[column] << marker
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
    class FullColumnError < StandardError; end
end