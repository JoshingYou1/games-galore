module ApplicationHelper
  def current_date
    Time.now.strftime("%Y-%m-%d")
  end
end
