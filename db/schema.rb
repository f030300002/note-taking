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

ActiveRecord::Schema.define(version: 20171017045346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "records", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "record_type"
    t.string   "title"
    t.decimal  "amount",      precision: 8, scale: 2, default: "0.0"
    t.text     "description"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.date     "record_date",                         default: '2017-10-15'
    t.index ["user_id"], name: "index_records_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "confirm_password"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.decimal  "wage",             precision: 8, scale: 2, default: "0.0"
  end

end
