class GroupEventsController < ApplicationController
  before_action :set_group_evet, only: [:publish, :destroy, :update]
  respond_to :json

  def create
    group_event = GroupEvent.create permitted_params
    if group_event.valid?
      head :created
    else
      head :unprocessable_entity
    end
  end

  def update
    return head :not_found unless @group_event
    if @group_event.update permitted_params
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def publish
    return head :not_found unless @group_event
    if @group_event.publish!
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def destroy
    return head :not_found unless @group_event
    @group_event.mark_as_deleted!
  end

  private

  def set_group_evet
    @group_event = GroupEvent.find_by id: params[:id]
  end

  def permitted_params
    params.permit(
      :user_id, :name, :description, :duration, :date_start, :location
    )
  end
end
