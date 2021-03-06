class LinkedList
    attr_reader :head, :tail, :size

    def initialize
        @head = nil
        @tail = nil
        @size = 0
    end

    def append node
        if @head.nil?
            @head = node
            @tail = node
        else
            @tail.next_node = node
            @tail = node
        end

        @size += 1
    end

    def at index
        node_index = 0
        current_node = @head

        while !current_node.nil?
            if node_index == index
                return current_node
            end

            current_node = current_node.next_node
            node_index += 1
        end

        throw IndexError
    end

    def contains? value
        current_node = @head

        while !current_node.nil?
            if current_node.value == value
                return true
            end
            current_node = current_node.next_node
        end

        false
    end

    def find value
        current_node = @head
        index = 0

        while !current_node.nil?
            if current_node.value == value
                return index
            end
            current_node = current_node.next_node
            index += 1
        end

        nil
    end

    def insert_at node, index
        # Immediately throw an exception if the given index
        # is out of bounds
        if index > @size or index < 0
            throw IndexError
        end

        if @size == 0
            # Set the new node as both the head and the tail
            # if the list is empty
            @head = node
            @tail = node
        elsif index == 0
            # Insert as the new head
            node.next_node = @head
            @head = node
        elsif index == @size
            # Insert as the new tail
            @tail.next_node = node
            @tail = node
        else
            # Insert somewhere in the middle of the list
            current_node = @head
            next_index = 1
            while !current_node.next_node.nil?
                if next_index == index
                    node.next_node = current_node.next_node
                    current_node.next_node = node
                    break
                else
                    next_index += 1
                    current_node = current_node.next_node
                end
            end
        end

        @size += 1
    end

    def pop
        if @head == @tail
            @head = nil
            @tail = nil
        else
            current_node = @head
            while current_node.next_node != @tail
                current_node = current_node.next_node
            end
            @tail = current_node
            @tail.next_node = nil
        end

        @size -= 1
    end

    def prepend node
        if @head.nil?
            @head = node
            @tail = node
        else
            node.next_node = @head
            @head = node
        end

        @size += 1
    end

    def remove_at index
        # Immediately throw an exception if the given index
        # is out of bounds
        if index >= @size or index < 0
            throw IndexError
        end

        # Set the head and tail to nil
        # if there's only one element to remove
        if @size == 1
            @head = nil
            @tail = nil
        elsif index == 0
            # Remove the head node from the list
            @head = @head.next_node
        else
            current_node = @head
            next_index = 1
            while !current_node.next_node.nil?
                if next_index == index
                    current_node.next_node = current_node.next_node.next_node
                    break
                else
                    next_index += 1
                    current_node = current_node.next_node
                end
            end
        end

        @size -= 1
    end

    def to_s
        list_string = ""
        current_node = @head

        while !current_node.nil?
            list_string += (current_node.to_s + " -> ")
            current_node = current_node.next_node
        end

        list_string += "nil"
    end
end

class Node
    attr_accessor :value, :next_node

    def initialize value=nil
        @value = value
        @next_node = nil
    end

    def to_s
        if !@value.nil?
            "(#{@value})"
        end
    end
end

# Basic functionality testing
puts "Creating some nodes and initializing list"
node1 = Node.new(1)
node2 = Node.new(2)
node3 = Node.new(3)
node4 = Node.new(4)
list = LinkedList.new
puts "List: #{list}"
puts "Size: #{list.size}"

puts "Appending 1"
list.append(node1)
puts "List: #{list}"
puts "Size: #{list.size}"

puts "Appending 2"
list.append(node2)
puts "List: #{list}"
puts "Size: #{list.size}"

puts "Appending 3"
list.append(node3)
puts "List: #{list}"
puts "Size: #{list.size}"

puts "Prepending 4"
list.prepend(node4)
puts "List: #{list}"
puts "Size: #{list.size}"

puts "Retrieving head node with #head"
puts "Head: #{list.head}"

puts "Retrieving tail node with #tail"
puts "Head: #{list.tail}"

puts "Getting the node at index 2 with #at"
puts "Index 2: #{list.at(2)}"

puts "Popping the tail node"
list.pop
puts "List: #{list}"

puts "Does the list contain 2? #{list.contains?(2)}"
puts "Does the list contain 3? #{list.contains?(3)}"

puts "Index of 2: #{list.find(2)}"
puts "Index of 3? #{list.find(3)}"

puts "Inserting at index 0"
list.insert_at(Node.new(0), 0)
puts "List: #{list}"

puts "List size: #{list.size}"

puts "Inserting at index #{list.size}"
list.insert_at(Node.new(99), list.size)
puts "List: #{list}"

puts "List size: #{list.size}"

puts "Inserting at index 4"
list.insert_at(Node.new(23), 4)
puts "List: #{list}"

puts "List size: #{list.size}"

puts "Removing at index 4"
list.remove_at(4)
puts "List: #{list}"

puts "List size: #{list.size}"

puts "Removing at index 0"
list.remove_at(0)
puts "List: #{list}"

puts "List size: #{list.size}"

puts "Removing at index #{list.size - 1}"
list.remove_at(list.size - 1)
puts "List: #{list}"