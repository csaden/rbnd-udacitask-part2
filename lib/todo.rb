class TodoItem
  include Listable
  attr_accessor :progress
  attr_reader :description, :due, :priority, :bar

  def initialize(description, options={})
    validatePriority options[:priority]
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    @bar = ProgressBar.new(100, :percentage)
    @progress = options[:progress] || 0
  end
  def progress=(progress)
    @progress = progress
    @bar.increment! @progress
  end
  def validatePriority(priority)
    valid_priorities = ["high", "medium", "low", nil]
    raise UdaciListErrors::InvalidPriorityTypeError, "Priority must be one of #{valid_priorities}" unless valid_priorities.include? priority
  end
  def details
    format_description(@description) + format_type(self.class) +
    format_progress(@bar) +
    "due: " + format_date(@due) +
    format_priority(@priority)
  end
end
