module UdaciListErrors
  # Error classes go here
  class InvalidItemTypeError < StandardError
  end
  class IndexExceedsListSizeError < StandardError
  end
  class InvalidPriorityTypeError < StandardError
  end
end
