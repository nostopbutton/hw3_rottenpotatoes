FactoryGirl.define do
  factory :movie do
    title 'A fake title'
    rating 'PG'
    director "Pete"
    release_date {10.years.ago}
  end
end