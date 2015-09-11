module ApplicationHelper

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible fade-in", role: 'alert') do
        concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
          concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
          concat content_tag(:span, 'Close', class: 'sr-only')
        end)
        concat content_tag(:strong, message)
      end)
    end
    nil
  end

  def color_code(num)
    if num <= 5
      "text-danger"
    elsif num <= 10
      "text-warning"
    else
      "text-info"
    end
  end

  def display_departures(departures)
    if departures.empty?
      "<span>No departures<span>".html_safe
    else
      str = ""
      departures.each do |num|
        str += "<span class='#{color_code(num)}'>#{num} minutes<span><br>"
      end
      str.html_safe
    end
  end

end
