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

    it "starts with \u26AA as player 1's marker" do
        expect(game.instance_variable_get(:@player_1_marker)).to eql("\u26AA")
    end

    it "starts with \u26AB as player 1's marker" do
        expect(game.instance_variable_get(:@player_2_marker)).to eql("\u26AB")
    end

    context "#drop" do
        it "raises a BadColumnError when given a bad column" do
            expect{ game.drop("\u26AA", -1) }.to raise_error(ConnectFour::BadColumnError)
        end

        it "raises a FullColumnError when given a full column" do
            game.instance_variable_get(:@columns)[0] = ["\u26AA", "\u26AB", "\u26AA", "\u26AB", "\u26AA", "\u26AB"]
            expect{ game.drop("\u26AA", 0) }.to raise_error(ConnectFour::FullColumnError)
        end

        it "works on an empty column" do
            game.drop("\u26AA", 0)
            expect(game.instance_variable_get(:@columns)[0].last).to eql("\u26AA")
        end

        it "works on a non-empty column" do
            game.instance_variable_get(:@columns)[0] << "\u26AA"
            game.drop("\u26AB", 0)
            expect(game.instance_variable_get(:@columns)[0]).to eql(["\u26AA", "\u26AB"])
        end
    end

    context "#check_for_vertical_win" do
        it "returns false when the given row is less than 3" do
            expect(game.check_for_vertical_win(0, 0, "\u26AA")).to eql(false)
        end

        it "returns true when the given row and column position is part of 4 in a row vertically" do
            game.instance_variable_get(:@columns)[0] = ["\u26AA", "\u26AA", "\u26AA", "\u26AA"]
            expect(game.check_for_vertical_win(3, 0, "\u26AA")).to eql(true)
        end

        it "returns false when the given row and column position does not make 4 in a row vertically" do
            game.instance_variable_get(:@columns)[0] = ["\u26AA", "\u26AA", "\u26AB", "\u26AA"]
            expect(game.check_for_vertical_win(3, 0, "\u26AA")).to eql(false)
        end
    end

    context "#check_for_horizontal_win" do
        it "returns true when the given row and column position is part of a 4 in a row horizontally" do
            game.instance_variable_set(:@columns, [["\u26AA"], ["\u26AA"], ["\u26AA"], ["\u26AA"], [], [], []])
            expect(game.check_for_horizontal_win(0, 0, "\u26AA")).to eql(true)
        end

        it "returns false when the given row and column position does not make 4 in a row horizontally" do
            game.instance_variable_set(:@columns, [["\u26AA"], ["\u26AB"], ["\u26AA"], ["\u26AA"], [], [], []])
            expect(game.check_for_horizontal_win(0, 0, "\u26AA")).to eql(false)
        end
    end
end