require "rails_helper"

describe GroupEvent do

  describe "#publish!" do
    context "when some of the fields is missing" do
      it "returns false" do
        user_group = GroupEvent.create! name: "testing"
        expect(user_group.publish!).to be_falsey
        expect(user_group.reload).not_to be_published
      end
    end

    context "when all fields present" do
      it "returns true and updates group event" do
        user_group = GroupEvent.create!(
          name: "testing", user_id: 1, location: "Riga",
          description: "<html></html>", date_start: Time.now, duration: 30
        )
        expect(user_group.publish!).to be_truthy
        expect(user_group.reload).to be_published
      end
    end
  end


  describe "#mark_as_deleted!" do
    it do
      user_group = GroupEvent.create! deleted: false
      user_group.mark_as_deleted!
      expect(user_group.reload).to be_deleted
    end
  end


  describe "#date_end" do
    subject do
      GroupEvent.new(date_start: Date.new(2017, 10, 10), duration: 1).date_end
    end
    it { is_expected.to eq Date.new(2017, 10, 11) }
  end

end
