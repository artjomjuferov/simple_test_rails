require "rails_helper"

describe GroupEventsController, type: :request do

  describe "#create" do
    context "when created all right" do
      it do
        expect do
          post "/group_events", params: {
            user_id: 1, name: "testing event"
          }
        end.to change { GroupEvent.count }.by(1)

        expect(response.status).to eq 201

        group_event = GroupEvent.first

        expect(group_event.user_id).to eq 1
        expect(group_event.name).to eq "testing event"
      end
    end

    context "when duration is -1" do
      it do
        expect do
          post "/group_events", params: {
            user_id: 1, name: "testing event", duration: -1
          }
        end.to change { GroupEvent.count }.by(0)

        expect(response.status).to eq 422
      end
    end
  end


  describe "#update" do
    context "when group event was not found" do
      it do
        put "/group_events/-1"
        expect(response.status).to eq 404
      end
    end

    context "when correctly updated" do
      it do
        group_event = GroupEvent.create! duration: 1

        put "/group_events/#{group_event.id}", params: { duration: 2 }

        expect(response.status).to eq 200
        expect(group_event.reload.duration).to eq 2
      end
    end

    context "when duration is -1" do
      it do
        group_event = GroupEvent.create! duration: 1

        put "/group_events/#{group_event.id}", params: { duration: -1 }

        expect(response.status).to eq 422
        expect(group_event.reload.duration).to eq 1
      end
    end
  end


  describe "#destroy" do
    context "when group event was not found" do
      it do
        delete "/group_events/-1"
        expect(response.status).to eq 404
      end
    end

    context "when deleted successfully" do
      it do
        group_event = GroupEvent.create!
        expect do
          delete "/group_events/#{group_event.id}"
        end.to change { GroupEvent.count }.by(0)
          .and change { group_event.reload.deleted? }.from(false).to(true)

        expect(response.status).to eq 204
      end
    end
  end


  describe "#publish" do
    let(:group_event){ GroupEvent.create! }

    context "when group event was not found" do
      before do
        expect_any_instance_of(GroupEvent).not_to receive(:publish!)
      end
      it do
        put "/group_events/-1/publish"
        expect(response.status).to eq 404
      end
    end

    context "when fields are missing" do
      let(:published_succesfully) { false }
      before do
        expect_any_instance_of(GroupEvent).to receive(:publish!)
          .and_return(false)
      end
      it do
        put "/group_events/#{group_event.id}/publish"
        expect(response.status).to eq 422
      end
    end

    context "when all fields are there and it's possible to publish" do
      let(:published_succesfully) { true }
      before do
        expect_any_instance_of(GroupEvent).to receive(:publish!)
          .and_return(true)
      end
      it do
        put "/group_events/#{group_event.id}/publish"
        expect(response.status).to eq 200
      end
    end
  end
end
