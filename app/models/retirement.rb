class Retirement < ApplicationRecord

  include Hashid::Rails
  include Sanitizable

  validates :name, presence: true, length: { maximum: 255 }
  validate :retirement_date_is_valid_date

  scope :random, -> { order(Arel.sql('RANDOM()')).limit(1).first }

  def retired?
    Time.current > retirement_date
  end

  def time_until_retirement
    return 0 if retired?
    retirement_date - Time.current
  end

  private

    def retirement_date_is_valid_date
      Date.parse(retirement_date.to_s) rescue errors.add(:retirement_date, 'must be a valid date')
    end

end
