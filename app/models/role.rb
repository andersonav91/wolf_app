class Role < ApplicationRecord
  has_many :job_seeker_roles, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
end
