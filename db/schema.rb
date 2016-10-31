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

ActiveRecord::Schema.define(version: 20161027160720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string   "full_name"
    t.string   "brand"
    t.integer  "sku"
    t.string   "category_1"
    t.integer  "product_code"
    t.boolean  "in_stock"
    t.text     "details"
    t.text     "sizes"
    t.string   "color"
    t.float    "price"
    t.string   "washing_instructions"
    t.string   "materials"
    t.text     "photo_urls"
    t.string   "product_url"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
