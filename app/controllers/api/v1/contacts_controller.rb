class Api::V1::ContactsController < ApplicationController
  before_action :authenticate_request
  
  # curl -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0OTkyOTczODQsImlzcyI6IkNvbnRhY3QgS2VlcGVyIiwiYXVkIjoiY2xpZW50In0.JTn6tbZpWwqMoebsykpEcClu45MIB303L_gs7DSavRU" http://localhost:3000/api/v1/contacts
  def index
    @contacts = User.find(current_user.id).contacts
    render json: { contacts: @contacts }, status: :ok
  end
  
  def show
    @contact = Contact.where(id: params[:id], user_id: current_user.id).first
    render json: { contact: @contact }, status: :ok
  end
  
  # curl -X POST -H "Content-Type: application/json" -d '{ "user": { "username": "jfriedman", "first_name": "Jeff", "last_name": "Friedman", "email": "test@test.com", "phone_number": "617-123-4567", "password": "password", "password_confirmation": "password" }}' http://localhost:3000/api/v1/users
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: { msg: 'Contact created!', contact: @contact }, status: :ok
    else
      render json: { error: @contact.errors.full_messages.join(', ') }, status: :bad_request
    end
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone_number, :notes)
  end
end