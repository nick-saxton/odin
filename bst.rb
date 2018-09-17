class BST
    def initialize data
        @root = nil
        build_tree_unsorted(@root, data)
    end

    def breadth_first_search value
        to_visit = [@root]
        while to_visit.size > 0
            node = to_visit.shift

            if node.value == value
                return node
            end

            if !node.left_child.nil?
                to_visit.push(node.left_child)
            end
            if !node.right_child.nil?
                to_visit.push(node.right_child)
            end
        end

        nil
    end

    def build_tree_sorted data
        if data.size == 0
            nil
        elsif data.size == 1
            Node.new(data[0])
        else
            # Get the midpoint of the data array
            midpoint = data.size / 2

            # Create a new node with the value of the midpoint
            node = Node.new(data[midpoint])

            # Create the left and right subtrees
            node.left_child = build_tree_sorted(data[0..(midpoint - 1)])
            node.right_child = build_tree_sorted(data[(midpoint + 1)..-1])

            # Set the node as the parent of the children (if they exist)
            if !node.left_child.nil?
                node.left_child.parent = node
            end
            if !node.right_child.nil?
                node.right_child.parent = node
            end

            node
        end
    end

    def build_tree_unsorted current_node, data
        # Ensure the data array actually contains values
        if data.size > 0
            # Handle an empty tree
            if current_node.nil?
                # Create the root node with the first element of the data array
                @root = Node.new(data.shift)
                # Build the rest of the tree
                build_tree_unsorted(@root, data)
            else
                # Grab the first element of the array for comparisons
                current_value = data[0]
                if current_value <= current_node.value
                    # If the element is less than or equal to the value of the current node
                    # then start looking at the left child of the current node
                    if !current_node.left_child.nil?
                        build_tree_unsorted(current_node.left_child, data)
                    else
                        node = Node.new(data.shift)
                        node.depth = current_node.depth + 1
                        current_node.left_child = node
                        node.parent = current_node
                        build_tree_unsorted(@root, data)
                    end
                else
                    # If the element is greater than the value of the current node
                    # then start looking at the right child of the current node
                    if !current_node.right_child.nil?
                        build_tree_unsorted(current_node.right_child, data)
                    else
                        node = Node.new(data.shift)
                        node.depth = current_node.depth + 1
                        current_node.right_child = node
                        node.parent = current_node
                        build_tree_unsorted(@root, data)
                    end
                end
            end
        end

        def to_s
            "--------------------------\n#{@root}--------------------------"
        end
    end

    def depth_first_search value
        to_visit = [@root]
        while to_visit.size > 0
            node = to_visit.pop

            if node.value == value
                return node
            end

            if !node.left_child.nil?
                to_visit.push(node.left_child)
            end
            if !node.right_child.nil?
                to_visit.push(node.right_child)
            end
        end

        nil
    end

    def dfs_rec value, node=@root
        if node.value == value
            node
        else
            if !node.left_child.nil?
                found = dfs_rec(value, node.left_child)
                if !found.nil?
                    return found
                end
            end
            if !node.right_child.nil?
                found = dfs_rec(value, node.right_child)
                if !found.nil?
                    return found
                end
            end

            nil
        end
    end


    class Node
        attr_accessor :parent, :left_child, :right_child, :depth
        attr_reader :value

        def initialize value=nil
            @value = value
            @parent = nil
            @left_child = nil
            @right_child = nil
            @depth = 0
        end

        def to_s
            str = "Node - Value: #{@value} - Depth: #{@depth}\n"
            if !@left_child.nil?
                str += @left_child.to_s
            end
            if !@right_child.nil?
                str += @right_child.to_s
            end
            str
        end
    end
end

def measure(&block)
    start = Time.now
    block.call
    Time.now - start
end

bst1 = BST.new([1])
puts bst1

bst2 = BST.new([1, 2])
puts bst2

bst3 = BST.new([1, 2, 3])
puts bst3

bst4 = BST.new(Array.new(100) { rand(1..100) })
puts bst4

t1 = measure { bst4.breadth_first_search(8) }
puts "BFS(8) on BST4: #{bst4.breadth_first_search(8)} Time: #{t1}"
t2 = measure { bst4.breadth_first_search(6) }
puts "BFS(6) on BST4: #{bst4.breadth_first_search(6)} Time: #{t2}"
t3 = measure { bst4.depth_first_search(8) }
puts "DFS(8) on BST4: #{bst4.depth_first_search(8)} Time: #{t3}"
t4 = measure { bst4.depth_first_search(6) }
puts "DFS(6) on BST4: #{bst4.depth_first_search(6)} Time: #{t4}"
t5 = measure { bst4.dfs_rec(8) }
puts "Recursive DFS(8) on BST4: #{bst4.dfs_rec(8)} Time: #{t5}"
t6 = measure { bst4.dfs_rec(6) }
puts "Recursive DFS(6) on BST4: #{bst4.dfs_rec(6)} Time: #{t6}"