FactoryBot.define do
  factory :location do
    name { Faker::Address.city }

    # in new york
    latitude { 40.7128 + rand(-0.43..0.43) }
    longitude { -74.0060 + rand(-0.43..0.43) }
  end

  # outside of new york
  factory :location_outside_30_miles, parent: :location do
    latitude { 40.7128 + rand(0.5..1.0) * [1, -1].sample }
    longitude { -74.0060 + rand(0.5..1.0) * [1, -1].sample }
  end
end

FactoryBot.define do
  factory :role do
    name { Faker::Job.title }
  end
end

FactoryBot.define do
  factory :job_seeker do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    location # Asocia automáticamente una Location existente o crea una nueva
    availability_start { Faker::Date.backward(days: 1) }
    availability_end { Faker::Date.forward(days: 1) }
  end
end

FactoryBot.define do
  factory :job_seeker_role do
    job_seeker
    role
    status { Faker::Boolean.boolean }
    rating { rand(1..10) }
  end
end