require 'faker'

puts "clearing seeds!"

Appointment.destroy_all
Offer.destroy_all
User.destroy_all

puts "seeding users!"

users = []
20.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city: Faker::Address.city,
    certification: Faker::University.name
  )
  photo = URI.open(Faker::Avatar.image)
  user.photo.attach(io: photo, filename: 'avatar.png', content_type: 'image/png')
  user.email = "#{user.first_name}.#{user.last_name}@email.com"
  user.password = "password"
  user.password_confirmation = "password"
  user.save!
  users << user
end

puts "seeding offers!"

offers = []
20.times do
  offer = Offer.new(
    title: Faker::Hobby.activity,
    details: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4),
    price: rand(10..40),
    duration: (0.75 + (rand(7) / 4)).to_s
  )
  offer.category = offer.title
  offer.user = users[rand(users.count - 1)]
  offer.save!
  offers << offer
end

puts "seeding appointments!"

30.times do
  appointment = Appointment.new(
    date: Faker::Date.between(from: Date.today, to: 1.year.from_now),
    status: true
  )
  appointment.offer = offers[rand(users.count - 1)]
  appointment.user = users[rand(users.count - 1)]
  appointment.user = users[rand(users.count - 1)] while appointment.user == appointment.offer.user
  appointment.save!
end

puts "done making seeds!"
