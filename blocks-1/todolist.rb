class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(t2)
    t2.is_a?(Todo) && title == t2.title
  end
end

class TodoList
  attr_accessor :title, :todos

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(td)
    raise TypeError, 'This is not a Todo' unless td.is_a?(Todo)
    todos << td
  end
  alias_method :<<, :add

  def size
    todos.size
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def item_at(n)
    raise IndexError, 'Index out of range' if n >= size
    todos[n]
  end

  def mark_done_at(n)
    raise IndexError, 'Index out of range' if n >= size
    todos[n].done!
  end

  def mark_undone_at(n)
    todos[n].undone!
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(n)
    raise IndexError, 'Index out of range' if n >= size
    todos.delete_at(n)
  end

  def each
    todos.each do |t|
      yield(t)
    end

    self
  end

  def to_a
    todos
  end

  def done?
    each { |td| return false unless td.done? }
    true
  end

  def to_s
    str = title + ':'
    todos.each do |t|
      str << ("\n" + t.to_s)
    end

    str
  end

  def select
    selected = TodoList.new("Selected List:")

    each do |td|
      selected.todos << td if yield(td)
    end

    selected
  end

  def find_by_title(str)
    each do |td|
      return td if td.title.downcase == str.downcase
    end

    nil
  end

  def all_done
    select { |td| td.done? }
  end

  def all_not_done
    select { |td| !td.done? }
  end

  def mark_done(str)
    find_by_title(str).done! unless !find_by_title(str)
  end

  def done!
    each { |td| td.done! }
  end

  def undone!
    each { |td| td.undone! }
  end

  def ==(tdl)
    tdl.is_a?(TodoList) && title == tdl.title && todos == tdl.todos
  end

end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

list.mark_done_at(1)

puts list

results = list.select { |todo| todo.done? }    # you need to implement this method

puts results.inspect
