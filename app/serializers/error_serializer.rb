module ErrorSerializer
    def self.serializer(errors)
        return if errors.nil?
        json = {}
        new_hash = errors.to_hash.map do |key, value|
            value.map do |item|
                {id: key, title: item}
            end
        end.flatten
        json[:errors] = new_hash
        json
    end
end