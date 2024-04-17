# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_16_230740) do
  create_table "job_seeker_roles", force: :cascade do |t|
    t.integer "job_seeker_id", null: false
    t.integer "role_id", null: false
    t.boolean "status"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_seeker_id"], name: "index_job_seeker_roles_on_job_seeker_id"
    t.index ["role_id", "status"], name: "index_job_seeker_roles_on_role_id_and_status"
    t.index ["role_id"], name: "index_job_seeker_roles_on_role_id"
    t.index ["status"], name: "index_job_seeker_roles_on_status"
  end

  create_table "job_seekers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "location_id", null: false
    t.date "availability_start"
    t.date "availability_end"
    t.index ["availability_end"], name: "index_job_seekers_on_availability_end"
    t.index ["availability_start"], name: "index_job_seekers_on_availability_start"
    t.index ["location_id"], name: "index_job_seekers_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["latitude", "longitude"], name: "index_locations_on_latitude_and_longitude"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "job_seeker_roles", "job_seekers"
  add_foreign_key "job_seeker_roles", "roles"
  add_foreign_key "job_seekers", "locations"
end
