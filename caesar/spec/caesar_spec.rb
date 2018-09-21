require "caesar"

describe "the caesar cipher function" do
    context "shifts a single" do
        context "lowercase character" do
            it "by 0" do
                expect(caesar_cipher("a", 0)).to eql("a")
            end

            it "in the positive direction" do
                expect(caesar_cipher("a", 2)).to eql("c")
            end

            it "in the negative direction" do
                expect(caesar_cipher("c", -2)).to eql("a")
            end

            it "in the positive direction with wraparound" do
                expect(caesar_cipher("z", 1)).to eql("a")
            end

            it "in the negative direction with wraparound" do
                expect(caesar_cipher("a", -1)).to eql("z")
            end
        end

        context "uppercase character" do
            it "by 0" do
                expect(caesar_cipher("A", 0)).to eql("A")
            end

            it "in the positive direction" do
                expect(caesar_cipher("A", 2)).to eql("C")
            end

            it "in the negative direction" do
                expect(caesar_cipher("C", -2)).to eql("A")
            end

            it "in the positive direction with wraparound" do
                expect(caesar_cipher("Z", 1)).to eql("A")
            end

            it "in the negative direction with wraparound" do
                expect(caesar_cipher("A", -1)).to eql("Z")
            end
        end
    end

    context "shifts a sentence" do
        it "by 0" do
            expect(caesar_cipher("The quick brown fox jumped over the lazy dog!", 0)).to eql("The quick brown fox jumped over the lazy dog!")
        end

        it "in the positive direction" do
            expect(caesar_cipher("The quick brown fox jumped over the lazy dog!", 1)).to eql("Uif rvjdl cspxo gpy kvnqfe pwfs uif mbaz eph!")
        end

        it "in the negative direction" do
            expect(caesar_cipher("The quick brown fox jumped over the lazy dog!", -1)).to eql("Sgd pthbj aqnvm enw itlodc nudq sgd kzyx cnf!")
        end
    end
end