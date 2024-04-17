class JobSeeker < ApplicationRecord
  has_many :job_seeker_roles, dependent: :destroy
  belongs_to :location

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }
  validate :validate_availability_dates

  scope :available_on_dates, ->(dates) {
    where(
      dates.map do |date|
        sanitize_sql_array(["? >= availability_start AND ? <= availability_end", date, date])
      end.join(' AND ')
    )
  }

  def self.find_candidates(role_id, latitude, longitude, dates)
    JobSeeker.joins(:job_seeker_roles, :location)
             .merge(Location.nearby(latitude, longitude))
             .where(job_seeker_roles: {role_id: role_id, status: true})
             .available_on_dates(dates)
             .order('job_seeker_roles.rating DESC')
             .limit(1000)
  end

  private

  def validate_availability_dates
    if availability_start.blank? || availability_end.blank?
      errors.add(:availability_start, "can't be blank") if availability_start.blank?
      errors.add(:availability_end, "can't be blank") if availability_end.blank?
    elsif availability_start >= availability_end
      errors.add(:availability_start, "must be before availability_end")
    end
  end
end
