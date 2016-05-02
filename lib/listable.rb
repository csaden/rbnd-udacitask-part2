module Listable
  def format_description(text)
    "#{text}".ljust(30)
  end
  def format_type(type)
    "#{type}".sub("Item", "").ljust(15)
  end
  def format_date(date, end_date=nil)
    if end_date.nil?
      date ? date.strftime("%D") : "No due date"
    else
      dates = date.strftime("%D") if date
      dates << " -- " + end_date.strftime("%D") if end_date
      dates = "N/A" if !dates
      dates
    end
  end
  def format_priority(priority)
    value = " ⇧".colorize(:magenta) if priority == "high"
    value = " ⇨".colorize(:yellow) if priority == "medium"
    value = " ⇩".colorize(:blue) if priority == "low"
    value = "" if !priority
    value
  end
  def format_progress(bar)
    bar.to_s.ljust(10)
  end
  def format_name(name)
    name ? name : ""
  end
end
