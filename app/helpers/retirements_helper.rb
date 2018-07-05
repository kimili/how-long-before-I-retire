module RetirementsHelper

  def time_difference_from_now(end_time, format = :sentence)
    start_time = Time.current.to_time
    end_time = end_time.to_time if end_time.respond_to?(:to_time)
    distance_in_seconds = ((end_time - start_time).abs).round
    format = :sentence unless %i[sentence score].include? format
    components = []

    %w[year month day].each do |interval|
      # For each interval type, if the amount of time remaining is greater than
      # one unit, calculate how many units fit into the remaining time.
      next if format == :sentence && distance_in_seconds < 1.send(interval)
      delta = (distance_in_seconds / 1.send(interval)).floor
      distance_in_seconds -= delta.send(interval)
      components <<
        if format == :score
          delta
        else
          "#{delta} #{delta == 1 ? interval : interval.pluralize}"
        end
    end
    return components.join('-') if format == :score
    components.to_sentence
  end
end

def retirement_name(retirement = @retirement)
  return retirement.name unless retirement.display_initials?
  retirement.name.split.map{ |v| "#{v[0].upcase}." }.join(' ')
end
