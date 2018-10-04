require 'tic_tac_toe'

describe Game do
    let(:game) { Game.new }

    describe "the validate_input method" do
        it "throws an exception when given bad input" do
            expect{ game.send(:validate_input, "d6") }.to raise_error(ArgumentError)
        end
    end

    describe "the convert_input method" do
        it "successfully converts the given input" do
            expect(game.send(:convert_input, "A1")).to eql([0, 0])
        end
    end
end

describe Game::Grid do
    let(:grid) { Game::Grid.new }

    describe "the mark method" do
        it "successfully marks an empty space" do
            grid.mark(0, 0, 'x')
            expect(grid.instance_variable_get(:@grid)).to eq([["x", " ", " "], [" ", " ", " "], [" ", " ", " "]])
        end

        it "throws an exception when an invalid row is given" do
            expect{ grid.mark(-1, 2, 'x') }.to raise_error(IndexError)
        end

        it "throws an exception when an invalid column is given" do
            expect{ grid.mark(1, 5, 'x') }.to raise_error(IndexError)
        end

        it "throws an exception when a previously marked space is given" do
            grid.mark(0, 0, 'x')
            expect{ grid.mark(0, 0, 'o') }.to raise_error(IndexError)
        end
    end

    describe "the win method" do
        it "returns true when an entire row matches" do
            grid.instance_variable_set(:@grid, [["x", "x", "x"], [" ", " ", " "], [" ", " ", " "]])
            expect(grid.win?("x")).to eql(true)
        end

        it "returns true when an entire column matches" do
            grid.instance_variable_set(:@grid, [["x", " ", " "], ["x", " ", " "], ["x", " ", " "]])
            expect(grid.win?("x")).to eql(true)
        end

        it "returns true when a diagonal matches" do
            grid.instance_variable_set(:@grid, [["x", " ", " "], [" ", "x", " "], [" ", " ", "x"]])
            expect(grid.win?("x")).to eql(true)
        end

        it "returns false when there's no win condition" do
            grid.instance_variable_set(:@grid, [["x", "o", "x"], ["o", "x", "o"], ["o", "x", "o"]])
            expect(grid.win?("x")).to eql(false)
        end
    end
end