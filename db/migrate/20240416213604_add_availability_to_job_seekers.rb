class AddAvailabilityToJobSeekers < ActiveRecord::Migration[7.1]
  def change
    add_column :job_seekers, :availability_start, :date
    add_column :job_seekers, :availability_end, :date
  end
end
