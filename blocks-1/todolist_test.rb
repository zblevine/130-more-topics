require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todolist'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(@list.size, 3)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    td = @list.shift
    assert_equal(@list.size, 2)
    assert_equal(td, @todo1)
  end

  def test_pop
    td = @list.pop
    assert_equal(td, @todo3)
    assert_equal(@list.size, 2)
  end

  def test_done!
    @list.done!
    @list.to_a.each { |td| assert(td.done!) }
  end

  def test_done?
    assert_equal(@list.done?, false)
    @list.done!
    assert(@list.done?)
  end

  def test_not_todo
    assert_raises(TypeError) { @list.add("Work work work work work") }
  end

  def test_both_adds
    @todo4 = Todo.new("Test an add")
    @list << @todo4
    @list.add(@todo4)
    assert_equal(@list.size, 5)
    assert_equal(@todos.to_a[3], @todos.to_a[4])
  end

  def test_item_at
    assert_equal(@list.item_at(1), @todo2)
    assert_raises(IndexError) { @list.item_at(12) }
  end

  def test_mark_done_at
    @list.mark_done_at(1)
    assert(@todo2.done?)
    assert_raises(IndexError) { @list.mark_done_at(12) }
  end

  def test_remove_at
    @list.remove_at(1)
    assert_equal(@list.size, 2)
    assert_raises(IndexError) { @list.remove_at(12) }
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    Today's Todos:
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_2
    @list.mark_done_at(1)

    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    Today's Todos:
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_3
    @list.done!

    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    Today's Todos:
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_each
    counter = 0
    returned = @list.each { |td| counter += 1 }
    assert_equal(counter, @list.size)
    assert_equal(returned, @list)
  end

  def test_select
    list2 = TodoList.new("Selected List:")
    list2 << @todo2
    @list.mark_done_at(1)
    assert_equal(@list.select { |td| td.done }, list2)
  end
  # Your tests go here. Remember they must start with "test_"

end