class CreateJobSeekerRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :job_seeker_roles do |t|
      t.references :job_seeker, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
      t.boolean :status
      t.integer :rating

      t.timestamps
    end
  end
end
