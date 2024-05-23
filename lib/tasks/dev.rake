namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    puts "Resetando o banco de dados"
    %x(rails db:drop db:create db:migrate)

    puts "Cadastrando os tipos de contato..."
    kinds = ["Amigo", "Comercial", "Conhecido"]
    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
    puts "Tipos contato cadastrados com sucesso"

    ####################

    puts "Cadastrando contatos..."
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Time.now,
        kind: Kind.all.sample
      )
    end
    puts "Contatos cadastrados com sucesso!"


    puts "Cadastrando numeros..."
      Contact.all.each do |contact|
        Random.rand(1..5).times do |i|
          contact.phones.create!(
            number: Faker::PhoneNumber.cell_phone
          )
        end
      end
    puts "Numeros cadastrados com sucesso!"

    puts "Cadastrando endereços..."
      Contact.all.each do |contact|
        Address.create!(
          street: Faker::Address.street_address,
          city: Faker::Address.city,
          contact: contact
        )
      end
    puts "Endereços cadastrados com sucesso"
  end
end