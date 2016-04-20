def map(arr)
  new_arr = []
  arr.each { |ele| new_arr << yield(ele) }
  new_arr
end

p map([1,2,3]) { |n| n + 2 }