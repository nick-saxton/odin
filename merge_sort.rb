def merge_sort arr
  # Base case
  if arr.length < 2
    return arr
  end
  
  # Sort the left half of the array
  left_half = merge_sort(arr[0..(arr.length / 2 - 1)])

  # Sort the right half of the array
  right_half = merge_sort(arr[(arr.length / 2)..-1])

  # Merge the resulting arrays
  left_index = 0
  right_index = 0
  result = []
  arr.length.times do
    # Concatenate the remainder of the right half onto the result
    # if no elements remain in the left half
    if left_index == left_half.length
      result += right_half[right_index..-1]
      break
    end

    # Concatenate the remainder of the left half onto the result
    # if no elements remain in the right half
    if right_index == right_half.length
      result += left_half[left_index..-1]
      break
    end

    # Compare the first element of the left half to the first
    # element of the right half and append the smaller value
    # to the result
    if left_half[left_index] < right_half[right_index]
      result << left_half[left_index]
      left_index += 1
    else
      result << right_half[right_index]
      right_index += 1
    end
  end

  result
end

p merge_sort [2, 1, 4]
p merge_sort [1, 1, 1, 1]
p merge_sort [1, 2, 3, 4, 5]
p merge_sort [6, 4, 2, 0]
p merge_sort [0, 6, 1, 5, 2, 4, 3]
p merge_sort [1]