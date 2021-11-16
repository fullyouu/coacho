require 'faker'

puts "seeding users!"

20.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city: Faker::Address.city,
    certification: Faker::University.name
  )
  user.email = "#{user.first_name}.#{user.last_name}@email.com"
  user.password = "password"
  user.password_confirmation = "password"
  user.save!
end

puts "seeding offers!"

20.times do
  offer = Offer.new(
    title: Faker::Hobby.activity,
    details: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4),
    price: rand(40),
    duration: (0.75 + (rand(7) / 4)).to_s
  )
  offer.category = offer.title
  offer.user = User.find(rand(1..20))
  offer.save!
end

puts "seeding appointments!"

30.times do
  appointment = Appointment.new(
    date: "#{rand(21..23)}#{rand(1..12)}#{rand(1..28)}#{rand(7..22)}#{rand(4) * 15}".to_i,
    status: true
  )
  appointment.offer = Offer.find(rand(1..20))
  appointment.user = User.find(rand(1..20))
  appointment.user = User.find(rand(1..20)) while appointment.user == appointment.offer.user
  appointment.save!
end

puts "done making seeds!"
