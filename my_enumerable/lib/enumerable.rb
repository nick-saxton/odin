module Enumerable
    def my_each
        # Try to convert 'self' to an array (it might already be an array)
        # so we can later access the elements by index
        array = self.to_a

        # Go through each element and perform the passed block
        array.length.times do |i|
            yield(array[i])
        end
    end

    def my_each_with_index
        # Try to convert 'self' to an array (it might already be an array)
        # so we can later access the elements by index
        array = self.to_a

        # Go through each element and perform the passed block
        array.length.times do |i|
            yield(array[i], i)
        end
    end

    def my_select
        array = []

        # If the passed block evaluates to "true"
        # then append the value to the selected values array
        self.my_each do |value|
            if yield(value)
                array << value
            end
        end

        array
    end

    def my_all?
        # Stop going through the enumerable immediately
        # if the passed block evaluates to "false"
        self.my_each do |value|
            if !yield(value)
                return false
            end
        end

        true
    end

    def my_any?
        # Stop going through the enumerable immediately
        # if the passed block evaluates to "true"
        self.my_each do |value|
            if yield(value)
                return true
            end
        end

        false
    end

    def my_none?
        # Stop going through the enumerable immediately
        # if the passed block evaluates to "false"
        self.my_each do |value|
            if yield(value)
                return false
            end
        end

        true
    end
end