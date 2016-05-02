class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    raise UdaciListErrors::InvalidItemTypeError, "Item type #{type} is not supported" unless ["todo", "event", "link"].include? type
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end
  def delete(index)
    raise UdaciListErrors::IndexExceedsListSizeError, "Failed to remove item at #{index}. Index out of bounds." unless index > 0 and index < @items.size
    @items.delete_at(index - 1)
  end
  def header_separator
    puts ("-" * @title.length).colorize(:white)
  end
  def print_title
    header_separator
    puts @title.colorize(:cyan)
    header_separator
  end
  def filter(type)
    filtered_items = @items.select{|item| item.class.name.downcase.sub("item", "") == type}
    if filtered_items.empty?
      puts "There are not items on the list with a type of #{type}."
    else
      filtered_items.each_with_index do |item, position|
        puts "#{position + 1}) #{item.details}"
      end
    end
  end
  def all
    print_title
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
