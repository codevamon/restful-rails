module V1
  class AddressesController < ApplicationController
    before_action :set_contact, only: [:show, :update, :create, :destroy]
  
    def show
      render json: @contact.address
    end
  
    def update
      if @contact.address.update(address_params)
        render json:  @contact.address
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end
  
    def create
      @contact.address = Address.new(address_params)
      if @contact.address.save
        render json: @contact.address, status: :created, location: contact_address_url(@contact.id)
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @contact.address.destroy
    end
  
    private
    def set_contact
      @contact = Contact.find(params[:contact_id])
    end
  
    def address_params 
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
  end
end
