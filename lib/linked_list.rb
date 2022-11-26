require_relative "linked_list/node"

class LinkedList
  attr_accessor :head, :tail
  
  def initialize(value = nil)
    @head = value ? Node.new(value) : nil
    @tail = @head
  end

  def each
    return if head.nil?
    current_node = head
    loop do
      yield(current_node)
      break if current_node.next_node.nil?
      current_node = current_node.next_node
    end
  end
  
  def append(value)
    # adds a new node containing value to the end of the list
    new_node = Node.new(value)
    if size > 0
      tail.next_node = new_node
    else
      self.head = new_node
    end
    self.tail = new_node
  end

  def prepend(value)
    # adds a new node containing value to the start of the list
    new_node = Node.new(value, head)
    self.head = new_node
  end

  def size
    # returns the total number of nodes in the list
    size_val = 0
    unless head.nil?
      each { |_| size_val += 1 }
    end
    size_val
  end

  def at(index)
    # returns the node at the given index
    if index >= size
      raise "No node at index #{index}. Length is #{size}."
    end

    current_index = 0
    return_value = nil
    each do |node|
      if current_index == index
        return_value = node
        break
      end
      current_index += 1
    end
    return_value
  end

  def pop
    # removes the last element from the list
    size_val = size
    if size_val == 0
      raise "Can't pop. Linked list is empty."
    elsif size_val == 1
      self.head = nil
      self.tail = nil
    elsif size_val == 2
      head.next_node = nil
      self.tail = head
    elsif size_val > 2
      new_tail = at(size_val - 2)
      self.tail = new_tail
      tail.next_node = nil
    end
  end

  def contains?(value)
    # returns true if the passed in value is in the list, otherwise returns
    # false.
    size_val = size
    if size_val == 0
      false
    else
      return_value = false
      each do |node|
        if node.value == value
          return_value = true
          break
        end
      end
      return_value
    end
  end

  def find(value)
    # returns the index of the node containing value, or nil if not found.
    index = 0
    did_find_value = false
    each do |node|
      if node.value == value
        did_find_value = true
        break
      end
      index += 1
    end
    if did_find_value
      return index
    end
    nil
  end

  def to_s
    # represent your LinkedList objects as strings, so you can print them out
    # and preview them in the console. The format should be:
    # ( value ) -> ( value ) -> ( value ) -> nil
    return_str = ""
    each do |node|
      return_str += "( #{node} ) -> "
    end
    return_str += "nil"
    return_str
  end
  
  # EXTRA CREDIT
  # Extra Credit Tip: When you insert or remove a node, consider how it will
  # affect the existing nodes. Some of the nodes will need their #next_node
  # link updated.

  def insert_at(value, index)
    # Extra credit
    # Inserts a new node with the provided value at the given index.
  end

  def remove_at(index)
    # Extra credit
    # Removes the node at the given index.
  end
end

ll = LinkedList.new
puts ll
puts ll.size
puts ll.tail
puts ll.find("test")
ll.append("foo")
ll.append("bar")
ll.append("blah")
puts ll.tail
puts ll
ll.pop
puts ll
puts ll.at(1)
ll.prepend("hiccup")
puts ll
puts ll.find("foo")
puts ll.find("hiccup")
puts ll.find("ssefsd")
