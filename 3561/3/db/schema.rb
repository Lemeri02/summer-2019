# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.
#rubocop:disable all

ActiveRecord::Schema.define(version: 2019_07_23_133824) do

  create_table "comments", force: :cascade do |t|
    t.string "text"
    t.integer "star"
    t.integer "user_id"
    t.integer "place_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.string "short_description"
    t.string "description"
    t.string "image_url"
    t.string "address"
    t.float "rating"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_hash"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
