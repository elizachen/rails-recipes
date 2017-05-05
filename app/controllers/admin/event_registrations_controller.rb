class Admin::EventRegistrationsController < ApplicationController
     before_action :find_event

   def index
    #  @registrations = @event.registrations.includes(:ticket).order("id DESC")
    @registrations = @event.registrations.includes(:ticket).order("id DESC").page(params[:page]).per(20)

    if Array(params[:statuses]).any?
      @registrations = @registrations.by_status(params[:statuses])
    end

    if Array(params[:ticket_ids]).any?
      @registrations = @registrations.by_ticket(params[:ticket_ids])
    end


    if params[:status].present? && Registration::STATUS.include?(params[:status])
      @registrations = @registrations.by_status(params[:status])
    end

    if params[:ticket_id].present?
      @registrations = @registrations.by_ticket(params[:ticket_id])
    end
   end

   def destroy
     @registration = @event.registrations.find_by_uuid(params[:id])
     @registration.destroy

     redirect_to admin_event_registrations_path(@event)
   end

   protected

   def find_event
     @event = Event.find_by_friendly_id!(params[:event_id])
   end

   protected

   def registration_params
     params.require(:registration).permit(:status, :ticket_id, :name, :email, :cellphone, :website, :bio)
   end

end
