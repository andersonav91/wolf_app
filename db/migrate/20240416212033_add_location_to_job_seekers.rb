class AddLocationToJobSeekers < ActiveRecord::Migration[7.1]
  def change
    add_reference :job_seekers, :location, null: false, foreign_key: true
  end
end
