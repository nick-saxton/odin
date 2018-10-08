require "connect_four"

describe ConnectFour do
    subject(:game) { ConnectFour.new }

    it "starts with seven columns" do
        expect(game.instance_variable_get(:@columns).length).to eql(7)
    end

    it "starts with completely empty columns" do
        game.instance_variable_get(:@columns).each do |column|
            expect(column.length).to eql(0)
        end
    end

    it "starts with x as player 1's marker" do
        expect(game.instance_variable_get(:@player_1_marker)).to eql("x")
    end

    it "starts with o as player 1's marker" do
        expect(game.instance_variable_get(:@player_2_marker)).to eql("o")
    end

    context "#drop" do
        it "raises a BadColumnError when given a bad column" do
            expect{ game.drop("x", -1) }.to raise_error(ConnectFour::BadColumnError)
        end

        it "raises a FullColumnError when given a full column" do
            game.instance_variable_get(:@columns)[0] = ["x", "o", "x", "o", "x", "o"]
            expect{ game.drop("x", 0) }.to raise_error(ConnectFour::FullColumnError)
        end

        it "works on an empty column" do
            game.drop("x", 0)
            expect(game.instance_variable_get(:@columns)[0].last).to eql("x")
        end

        it "works on a non-empty column" do
            game.instance_variable_get(:@columns)[0] << "x"
            game.drop("o", 0)
            expect(game.instance_variable_get(:@columns)[0]).to eql(["x", "o"])
        end
    end

    context "#check_for_vertical_win" do
        it "returns false when the given row is less than 3" do
            expect(game.check_for_vertical_win(0, 0, "x")).to eql(false)
        end

        it "returns true when the given row and column position is part of 4 in a row vertically" do
            game.instance_variable_get(:@columns)[0] = ["x", "x", "x", "x"]
            expect(game.check_for_vertical_win(3, 0, "x")).to eql(true)
        end

        it "returns false when the given row and column position does not make 4 in a row vertically" do
            game.instance_variable_get(:@columns)[0] = ["x", "x", "o", "x"]
            expect(game.check_for_vertical_win(3, 0, "x")).to eql(false)
        end
    end

    context "#check_for_horizontal_win" do
        it "returns true when the given row and column position is part of 4 in a row horizontally" do
            game.instance_variable_set(:@columns, [["x"], ["x"], ["x"], ["x"], [], [], []])
            expect(game.check_for_horizontal_win(0, 0, "x")).to eql(true)
        end

        it "returns false when the given row and column position does not make 4 in a row horizontally" do
            game.instance_variable_set(:@columns, [["x"], ["o"], ["x"], ["x"], [], [], []])
            expect(game.check_for_horizontal_win(0, 0, "x")).to eql(false)
        end
    end

    context "#check_for_diagonal_win" do
        it "returns true when the given row and column position is part of 4 in a row diagonally" do
            game.instance_variable_set(:@columns, [["x"], ["o", "x"], ["x", "o", "x"], ["x", "o", "x", "x"], [], [], []])
            expect(game.check_for_diagonal_win(2, 2, "x")).to eql(true)
        end

        it "returns false when the given row and column position is not part of 4 in a row diagonally" do
            game.instance_variable_set(:@columns, [["x"], ["o", "x"], ["x", "o", "x"], ["x", "o", "x", "x"], [], [], []])
            expect(game.check_for_diagonal_win(3, 1, "o")).to eql(false)
        end
    end

    context "#check_for_tie" do
        it "returns true if every space has been filled in the grid" do
            game.instance_variable_set(:@columns, [["x", "x", "o", "o", "x", "x"], ["x", "x", "o", "o", "x", "x"], ["o", "o", "x", "x", "o", "o"], ["o", "o", "x", "x", "o", "o"], ["x", "x", "o", "o", "x", "x"], ["x", "x", "o", "o", "x", "x"], ["o", "o", "x", "x", "o", "o"]])
            expect(game.check_for_tie).to eql(true)
        end

        it "returns false if there are still spaces to mark" do
            game.instance_variable_set(:@columns, [["x", "x", "o", "o", "x"], ["x", "x", "o", "o", "x", "x"], ["o", "o", "x", "x", "o", "o"], ["o", "o", "x", "x", "o", "o"], ["x", "x", "o", "o", "x", "x"], ["x", "x", "o", "o", "x", "x"], ["o", "o", "x", "x", "o", "o"]])
            expect(game.check_for_tie).to eql(false)
        end
    end

    context "#handle_input" do
        it "raises a BadColumnError if given anything other than a number from 1 to 7" do
            expect{ game.handle_input("a") }.to raise_error(ConnectFour::BadColumnError)
        end

        it "returns the given number (1-7) minus 1" do
            expect(game.handle_input("1")).to eql(0)
        end
    end
end