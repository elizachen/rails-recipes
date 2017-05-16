class EventsController < ApplicationController

  def index
    # @events = Event.all
    # @events = Event.rank(:row_order).all
     @events = Event.only_public.rank(:row_order).all
  end

  def show
    # @event = Event.find(params[:id])
    #  @event = Event.find_by_friendly_id!(params[:id])
     @event = Event.only_available.find_by_friendly_id!(params[:id])   # 如果活动是 draft 的话，经过 only_available scope 就会找不到，这就是我们的目的

  end

end
