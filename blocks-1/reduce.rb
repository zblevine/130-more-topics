def reduce(arr, init=arr.shift)
  acc = init
  arr.each {|num| acc = yield(acc, num) }
  acc
end

array = [1, 2, 3, 4, 5]
p reduce(array) { |acc, num| acc + num }

array2 = [2, 3, 5, 7, 11]
p reduce(array2, 10) { |acc, num| acc + num } 