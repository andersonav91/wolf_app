class Location < ApplicationRecord
  extend Geocoder::Model::ActiveRecord

  has_many :job_seekers, dependent: :destroy

  reverse_geocoded_by :latitude, :longitude

  scope :nearby, ->(lat, lon, distance_in_miles = 30) {
    near([lat, lon], distance_in_miles, units: :mi)
  }

  validates :name, presence: true, length: { maximum: 50 }
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }, allow_nil: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_nil: true
end
