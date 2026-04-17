puts 'Seeding users and properties...'

User.find_or_create_by!(email: 'demo@landchecker.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
end

property_types = %w[house apartment townhouse unit land]

200.times do |i|
  Property.find_or_create_by!(title: "Sample Property ##{i + 1}") do |property|
    property.address = "#{100 + i} Example St, Sydney NSW"
    property.property_type = property_types.sample
    property.bedrooms = rand(1..5)
    property.bathrooms = rand(1..3)
    property.price_cents = rand(350_000..2_500_000) * 100
    property.status = %w[active active active sold].sample
    property.listed_at = rand(120).days.ago
  end
end

puts 'Done.'
