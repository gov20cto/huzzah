module FeaturesHelper
  def pretty_date(date)
    return date unless date.is_a?(Time)
    return date.strftime("%B %d, %Y")
  end
end
