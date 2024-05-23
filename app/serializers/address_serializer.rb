class AddressSerializer < ActiveModel::Serializer
  attributes :city
  belongs_to :contact do 
    link(:related) { contact_address_url(object.id) }
  end
end