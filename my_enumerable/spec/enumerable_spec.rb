require 'enumerable'

describe "the enumerable module's" do
    context "my_each function" do
        it "touches every value in an array" do
            results = []

            [1, 2, 3].my_each do |value|
                results << value * 2
            end

            expect(results).to eql([2, 4, 6])
        end
    end

    context "my_each_with_index function" do
        it "touches every value in an array and provides the index" do
            [0, 1, 2].my_each_with_index do |value, index|
                expect(value).to eql(index)
            end
        end
    end

    context "my_select function" do
        it "selects elements for which the passed block evaluates to true" do
            expected = [2, 4, 6]

            results = [1, 2, 3, 4, 5, 6].my_select {|n| n % 2 == 0}

            expect(results).to eql(expected)
        end
    end

    context "my_all? function" do
        it "returns TRUE if the passed block evaluates to true for each value" do
            result = [1, 3, 5].my_all? {|n| n % 2 != 0}
            expect(result).to eql(true)
        end

        it "returns FALSE if the passed block evaluates to false for any of the values" do
            result = [1, 2, 3, 5].my_all? {|n| n % 2 != 0}
            expect(result).to eql(false)
        end
    end

    context "my_any? function" do
        it "returns TRUE if the passed block evaluates to true for any of the values" do
            result = [2, 3, 6].my_any? {|n| n % 2 != 0}
            expect(result).to eql(true)
        end

        it "returns FALSE if the passed block evaluates to false for every value" do
            result = [2, 4, 6, 8].my_any? {|n| n % 2 != 0}
            expect(result).to eql(false)
        end
    end

    context "my_none? function" do
        it "returns TRUE if the passed block evaluates to false for every value" do
            result = [2, 4, 6, 8].my_none? {|n| n % 2 != 0}
            expect(result).to eql(true)
        end

        it "returns FALSE if the passed block evaluates to true for any of the values" do
            result = [2, 3, 4, 6, 8].my_none? {|n| n % 2 != 0}
            expect(result).to eql(false)
        end
    end
end
