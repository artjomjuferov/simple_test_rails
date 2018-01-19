class GroupEvent::AllFieldsAreRequired
  def initialize group_event
    @group_event = group_event
  end

  def call
    %w[user_id name description location duration date_start].each do |field|
      return unless present? field
    end
    true
  end

  private

  def present? key
    value = @group_event.send(key)
    !value.blank?
  end
end
