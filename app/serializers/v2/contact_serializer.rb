module V2
    class ContactSerializer < ActiveModel::Serializer
        attributes :id, :name, :email, :birthdate
      
        belongs_to :kind do 
          link(:related) { v2_contact_kind_url(object.id) }
        end
        has_many :phones do 
          link(:related) { v2_contact_phones_url(object.id) }
        end
        has_one :address do 
          link(:related) { v2_contact_address_url(object.id) }
        end
      
        # link(:self) { contacts_url(object.id) }
      
        def attributes(*args)
          h = super(*args)
          # PT-BR
          h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
          h
        end
      
      end      
end