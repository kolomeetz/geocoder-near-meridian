class City < ApplicationRecord
  after_validation :geocode

  geocoded_by :address
end
