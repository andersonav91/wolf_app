class JobSeekerRole < ApplicationRecord
  belongs_to :job_seeker
  belongs_to :role

  validates :status, inclusion: { in: [true, false] }
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }, allow_nil: false
end
