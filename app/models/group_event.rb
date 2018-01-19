class GroupEvent < ApplicationRecord
  validates :duration, numericality: { greater_than: 0 }, if: :duration

  def mark_as_deleted!
    self.update(deleted: true)
  end

  def publish!
    return unless GroupEvent::AllFieldsAreRequired.new(self).call
    self.update(published: true)
  end

  def date_end
    self.date_start + self.duration.days
  end
end
