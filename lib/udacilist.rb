class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    allowed_types = {todo: TodoItem, event: EventItem, link: LinkItem}
    if allowed_types.keys.include? type.to_sym
      @items.push allowed_types[type.to_sym].new description, options
    else
      raise UdaciListErrors::InvalidItemTypeError, "#{type} does not exist."
    end
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
