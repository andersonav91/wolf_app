class AddIndicesToModels < ActiveRecord::Migration[7.1]
  def change
    add_index :job_seekers, :availability_start
    add_index :job_seekers, :availability_end
    add_index :job_seeker_roles, :status
    add_index :job_seeker_roles, [:role_id, :status]
    add_index :locations, [:latitude, :longitude]
  end
end
