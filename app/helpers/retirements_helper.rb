module RetirementsHelper

  def time_difference_from_now(end_time, format = :sentence)
    start_time = Time.current.to_time
    end_time = end_time.to_time if end_time.respond_to?(:to_time)
    distance_in_seconds = ((end_time - start_time).abs).round
    format = :sentence unless %i[sentence header score].include? format
    components = []

    %w[year month day].each do |interval|
      # For each interval type, if the amount of time remaining is greater than
      # one unit, calculate how many units fit into the remaining time.
      next if (format == :sentence || format == :header) && distance_in_seconds < 1.send(interval)
      delta = (distance_in_seconds / 1.send(interval)).floor
      distance_in_seconds -= delta.send(interval)
      components <<
        if format == :score
          delta
        else
          "<strong>#{delta}</strong> #{delta == 1 ? interval : interval.pluralize}"
        end
    end
    return components.join('-') if format == :score
    return strip_tags components.to_sentence if format == :sentence
    components.join('<br>').html_safe
  end
end

def retirement_name(retirement = @retirement)
  return retirement.name unless retirement.display_initials?
  retirement.name.split.map{ |v| "#{v[0].upcase}." }.join(' ')
end

def encoded_share_text(retirement = @retirement)
  return nil unless retirement.present?
  share_text =
    if retirement.retired?
      translate 'share_text.retired'
    else
      translate 'share_text.not_retired', countdown: time_difference_from_now(retirement.retirement_date)
    end
  URI.encode_www_form_component share_text
end
