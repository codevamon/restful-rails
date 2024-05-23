module V1
  class PhonesController < ApplicationController
    before_action :set_contact, only: [:index, :show, :create, :update, :destroy]

    def index
      render json: @contact.phones
    end
  
    def show
      render json: @contact.phones.find(params[:id])
    end
  
    def create
      @contact.phones << Phone.new(phone_params)
      if @contact.phones.last.save
        render json: @contact.phones, status: :created, location: contact_phone_url(@contact.id)
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @contact.phones.find(phone_params[:id]).update(phone_params)
        render json: @contact.phones
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @contact.phones.find(phone_params[:id]).destroy
    end
  
    private
  
    def phone_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
  
    def set_contact
      @contact = Contact.find(params[:contact_id])
    end
  
  end
end