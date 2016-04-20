def each(arr)
  count = 0
  while count < arr.size
    yield(arr[count])
    count += 1
  end
end

each([1,2,3,4,5]) do |n|
  puts n
end