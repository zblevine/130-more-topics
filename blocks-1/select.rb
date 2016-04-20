def select(arr)
  counter = 0
  selected = []

  while counter < arr.size
    selected << arr[counter] if yield(arr[counter])
    counter += 1
  end

  selected
end

array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? }      # => [1, 3, 5]
p select(array) { |num| puts num }      # => [], because "puts num" returns nil and evaluates to false
p select(array) { |num| num + 1 }  
