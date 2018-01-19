require "rails_helper"

describe GroupEvent::AllFieldsAreRequired do

  describe "#call" do
    subject do
      GroupEvent::AllFieldsAreRequired.new(group_event).call
    end

    context "when user_id is missing" do
      let(:group_event) do
        instance_double(GroupEvent,
          user_id: nil, name: "name", description: "description",
          location: "location", date_start: 1.day.ago.to_date, duration: 1
        )
      end
      it { is_expected.to be_falsey }
    end

    context "when name is missing" do
      let(:group_event) do
        instance_double(GroupEvent,
          user_id: 2, name: nil, description: "description",
          location: "location", date_start: 1.day.ago.to_date, duration: 1
        )
      end
      it { is_expected.to be_falsey }
    end

    context "when description is missing" do
      let(:group_event) do
        instance_double(GroupEvent,
          user_id: 2, name: "name", description: nil,
          location: "location", date_start: 1.day.ago.to_date, duration: 1
        )
      end
      it { is_expected.to be_falsey }
    end

    context "when location is missing" do
      let(:group_event) do
        instance_double(GroupEvent,
          user_id: 2, name: "name", description: "description",
          location: nil, date_start: 1.day.ago.to_date, duration: 1
        )
      end
      it { is_expected.to be_falsey }
    end

    context "when date_start is missing" do
      let(:group_event) do
        instance_double(GroupEvent,
          user_id: 2, name: "name", description: "description",
          location: "location", date_start: nil, duration: 1
        )
      end
      it { is_expected.to be_falsey }
    end

    context "when duration is missing" do
      let(:group_event) do
        instance_double(GroupEvent,
          user_id: 2, name: "name", description: "description",
          location: "location", date_start: 1.day.ago.to_date, duration: nil
        )
      end
      it { is_expected.to be_falsey }
    end

    context "when all fiels are ther" do
      let(:group_event) do
        instance_double(GroupEvent,
          user_id: 2, name: "name", description: "description",
          location: "location", date_start: 1.day.ago.to_date, duration: 1
        )
      end
      it { is_expected.to be_truthy }
    end
  end


  describe "#_present?" do
    subject do
      group_event = instance_double(GroupEvent, name: value)
      GroupEvent::AllFieldsAreRequired.new(group_event).send(:present?, 'name')
    end

    context "when value is nil" do
      let(:value) { nil }
      it { is_expected.to be_falsey }
    end

    context "when value is empty string" do
      let(:value) { "" }
      it { is_expected.to be_falsey }
    end

    context "when value is not empty string" do
      let(:value) { "john" }
      it { is_expected.to be_truthy }
    end
  end
end
