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

ActiveRecord::Schema[7.1].define(version: 2024_03_30_171804) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.integer "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "administrators", force: :cascade do |t|
    t.datetime "current_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "email"
    t.string "encrypted_password"
    t.boolean "has_authority_to_write"
    t.datetime "last_sign_in_at", precision: nil
    t.string "last_sign_in_ip"
    t.string "name"
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.integer "sign_in_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_administrators_on_email"
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token"
  end

  create_table "album_audio", force: :cascade do |t|
    t.integer "album_order"
    t.integer "album_id"
    t.integer "audio_id"
    t.index ["album_id"], name: "index_album_audio_on_album_id"
    t.index ["audio_id"], name: "index_album_audio_on_audio_id"
  end

  create_table "album_keywords", force: :cascade do |t|
    t.integer "album_id"
    t.integer "keyword_id"
    t.index ["album_id"], name: "index_album_keywords_on_album_id"
    t.index ["keyword_id"], name: "index_album_keywords_on_keyword_id"
  end

  create_table "album_pictures", force: :cascade do |t|
    t.integer "album_order"
    t.integer "album_id"
    t.boolean "is_coverpicture"
    t.integer "picture_id"
    t.index ["album_id"], name: "index_album_pictures_on_album_id"
    t.index ["picture_id"], name: "index_album_pictures_on_picture_id"
  end

  create_table "albums", force: :cascade do |t|
    t.string "album_artist"
    t.integer "album_pictures_sorter_id"
    t.string "artist"
    t.integer "audio_count"
    t.string "copyright_markup_type"
    t.text "copyright_markup_text"
    t.date "date_released"
    t.string "description_markup_type"
    t.text "description_markup_text"
    t.boolean "index_can_display_tracklist"
    t.boolean "index_tracklist_audio_includes_subtitles"
    t.string "personnel_markup_type"
    t.text "personnel_markup_text"
    t.integer "keywords_count"
    t.string "musicians_markup_type"
    t.text "musicians_markup_text"
    t.integer "pictures_count"
    t.boolean "show_can_cycle_pictures"
    t.boolean "show_can_have_more_pictures_link"
    t.string "slug"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vendor_widget_gumroad"
    t.boolean "show_can_have_vendor_widget_gumroad"
    t.string "visibility"
    t.index ["slug"], name: "index_albums_on_slug"
  end

  create_table "arlocal_settings", force: :cascade do |t|
    t.string "admin_index_audio_sorter_id"
    t.boolean "admin_forms_auto_keyword_enabled"
    t.integer "admin_forms_auto_keyword_id"
    t.boolean "admin_forms_edit_slug_field"
    t.string "admin_forms_selectable_pictures_sorter_id"
    t.string "admin_index_pictures_sorter_id"
    t.boolean "marquee_enabled"
    t.integer "artist_content_copyright_year_earliest"
    t.integer "artist_content_copyright_year_latest"
    t.string "artist_name"
    t.string "audio_default_isrc_country_code"
    t.string "audio_default_isrc_registrant_code"
    t.string "marquee_markup_type"
    t.string "marquee_markup_text"
    t.string "icon_source_imported_file_path"
    t.boolean "html_head_public_can_include_meta_description"
    t.string "public_index_albums_sorter_id"
    t.boolean "public_nav_can_include_albums"
    t.boolean "public_nav_can_include_events"
    t.boolean "public_nav_can_include_info"
    t.boolean "public_nav_can_include_pictures"
    t.string "public_index_pictures_sorter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "public_nav_can_include_audio"
    t.integer "admin_index_albums_sorter_id"
    t.integer "admin_index_events_sorter_id"
    t.integer "public_index_audio_sorter_id"
    t.integer "public_index_events_sorter_id"
    t.boolean "audio_default_date_released_enabled"
    t.date "audio_default_date_released"
    t.boolean "admin_forms_retain_pane_for_neighbors"
    t.boolean "public_nav_can_include_stream"
    t.integer "admin_index_videos_sorter_id"
    t.integer "public_index_videos_sorter_id"
    t.boolean "public_nav_can_include_videos"
    t.string "icon_source_type"
    t.integer "admin_index_isrc_sorter_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "author"
    t.text "copyright_markup_text"
    t.string "content_markup_type"
    t.datetime "date_released", precision: nil
    t.text "content_markup_text"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "copyright_markup_type"
    t.string "slug"
    t.string "summary_markup_type"
    t.text "summary_markup_text"
    t.string "visibility"
    t.index ["slug"], name: "index_articles_on_slug"
  end

  create_table "audio", force: :cascade do |t|
    t.string "artist"
    t.string "audio_artist"
    t.integer "albums_count"
    t.string "source_imported_file_path"
    t.string "composer"
    t.string "copyright_markup_type"
    t.text "copyright_markup_text"
    t.date "date_released"
    t.string "description_markup_type"
    t.text "description_markup_text"
    t.integer "duration_hrs"
    t.integer "duration_mins"
    t.integer "duration_secs"
    t.integer "duration_mils"
    t.string "personnel_markup_type"
    t.text "personnel_markup_text"
    t.string "isrc_country_code"
    t.string "isrc_registrant_code"
    t.string "isrc_year_of_reference"
    t.string "isrc_designation_code"
    t.integer "keywords_count"
    t.string "musicians_markup_type"
    t.text "musicians_markup_text"
    t.string "subtitle"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "events_count"
    t.string "source_type"
    t.string "slug"
    t.string "visibility"
    t.index ["slug"], name: "index_audio_on_slug"
    t.index ["source_imported_file_path"], name: "index_audio_on_source_imported_file_path"
  end

  create_table "audio_keywords", force: :cascade do |t|
    t.integer "audio_id"
    t.integer "keyword_id"
    t.index ["audio_id"], name: "index_audio_keywords_on_audio_id"
    t.index ["keyword_id"], name: "index_audio_keywords_on_keyword_id"
  end

  create_table "event_audio", force: :cascade do |t|
    t.integer "event_order"
    t.integer "event_id"
    t.integer "audio_id"
    t.index ["audio_id"], name: "index_event_audio_on_audio_id"
    t.index ["event_id"], name: "index_event_audio_on_event_id"
  end

  create_table "event_keywords", force: :cascade do |t|
    t.integer "event_id"
    t.integer "keyword_id"
    t.index ["event_id"], name: "index_event_keywords_on_event_id"
    t.index ["keyword_id"], name: "index_event_keywords_on_keyword_id"
  end

  create_table "event_pictures", force: :cascade do |t|
    t.integer "event_order"
    t.integer "event_id"
    t.boolean "is_coverpicture"
    t.integer "picture_id"
    t.index ["event_id"], name: "index_event_pictures_on_event_id"
    t.index ["picture_id"], name: "index_event_pictures_on_picture_id"
  end

  create_table "event_videos", force: :cascade do |t|
    t.integer "event_id"
    t.integer "event_order"
    t.integer "video_id"
    t.index ["event_id"], name: "index_event_videos_on_event_id"
    t.index ["video_id"], name: "index_event_videos_on_video_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "city"
    t.string "details_markup_type"
    t.text "details_markup_text"
    t.string "event_pictures_sorter_id"
    t.integer "keywords_count"
    t.text "map_url"
    t.integer "pictures_count"
    t.boolean "show_can_cycle_pictures"
    t.boolean "show_can_have_more_pictures_link"
    t.string "slug"
    t.text "title_markup_text"
    t.text "venue_url"
    t.string "venue"
    t.boolean "visible_in_public_events_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "audio_count"
    t.integer "datetime_year"
    t.integer "datetime_month"
    t.integer "datetime_day"
    t.integer "datetime_hour"
    t.integer "datetime_min"
    t.string "datetime_zone"
    t.datetime "datetime_utc", precision: nil
    t.string "alert"
    t.string "title_markup_type"
    t.text "title_without_markup"
    t.integer "videos_count"
    t.string "visibility"
    t.index ["slug"], name: "index_events_on_slug"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at", precision: nil
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "infopage_items", force: :cascade do |t|
    t.integer "infopage_id"
    t.string "infopage_group"
    t.integer "infopage_group_order"
    t.string "infopageable_type"
    t.integer "infopageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["infopage_id"], name: "index_infopage_items_on_infopage_id"
    t.index ["infopageable_type", "infopageable_id"], name: "index_infopage_items_on_infopageable"
  end

  create_table "infopages", force: :cascade do |t|
    t.integer "index_order"
    t.string "slug"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "visibility"
    t.index ["slug"], name: "index_infopages_on_slug"
  end

  create_table "keywords", force: :cascade do |t|
    t.integer "albums_count"
    t.integer "audio_count"
    t.boolean "can_select_albums"
    t.boolean "can_select_pictures"
    t.integer "events_count"
    t.integer "pictures_count"
    t.string "slug"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "videos_count"
    t.boolean "can_select_videos"
    t.boolean "can_select_events"
    t.integer "order_selecting_albums"
    t.integer "order_selecting_events"
    t.integer "order_selecting_pictures"
    t.integer "order_selecting_videos"
    t.boolean "can_select_audio"
    t.index ["slug"], name: "index_keywords_on_slug"
  end

  create_table "links", force: :cascade do |t|
    t.string "address_href"
    t.string "address_inline_text"
    t.string "details_markup_type"
    t.text "details_markup_text"
    t.string "display_method"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "visibility"
  end

  create_table "picture_keywords", force: :cascade do |t|
    t.integer "keyword_id"
    t.integer "picture_id"
    t.index ["keyword_id"], name: "index_picture_keywords_on_keyword_id"
    t.index ["picture_id"], name: "index_picture_keywords_on_picture_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.integer "albums_count"
    t.string "source_imported_file_path"
    t.string "credits_markup_type"
    t.text "credits_markup_text"
    t.string "datetime_cascade_method"
    t.string "datetime_cascade_value"
    t.string "datetime_from_exif"
    t.datetime "datetime_from_file", precision: nil
    t.integer "datetime_from_manual_entry_year"
    t.integer "datetime_from_manual_entry_month"
    t.integer "datetime_from_manual_entry_day"
    t.integer "datetime_from_manual_entry_hour"
    t.integer "datetime_from_manual_entry_minute"
    t.integer "datetime_from_manual_entry_second"
    t.string "description_markup_type"
    t.text "description_markup_text"
    t.integer "events_count"
    t.integer "keywords_count"
    t.boolean "show_can_display_title"
    t.boolean "show_credit_uses_label"
    t.string "slug"
    t.string "title_markup_type"
    t.text "title_markup_text"
    t.string "title_without_markup"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "datetime_from_manual_entry_zone"
    t.string "source_type"
    t.integer "videos_count"
    t.string "visibility"
    t.index ["slug"], name: "index_pictures_on_slug"
  end

  create_table "streams", force: :cascade do |t|
    t.string "description_markup_type"
    t.text "description_markup_text"
    t.text "html_element"
    t.string "slug"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "visibility"
  end

  create_table "video_keywords", force: :cascade do |t|
    t.integer "keyword_id"
    t.integer "video_id"
    t.index ["keyword_id"], name: "index_video_keywords_on_keyword_id"
    t.index ["video_id"], name: "index_video_keywords_on_video_id"
  end

  create_table "video_pictures", force: :cascade do |t|
    t.integer "video_id"
    t.integer "picture_id"
    t.boolean "is_coverpicture"
    t.integer "video_order"
    t.index ["picture_id"], name: "index_video_pictures_on_picture_id"
    t.index ["video_id"], name: "index_video_pictures_on_video_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "copyright_markup_type"
    t.text "copyright_markup_text"
    t.date "date_released"
    t.string "description_markup_type"
    t.text "description_markup_text"
    t.string "personnel_markup_type"
    t.text "personnel_markup_text"
    t.string "slug"
    t.string "source_imported_file_path"
    t.integer "source_dimension_height"
    t.integer "source_dimension_width"
    t.string "source_type"
    t.string "source_url"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "keywords_count"
    t.text "source_embed"
    t.string "isrc_country_code"
    t.string "isrc_designation_code"
    t.string "isrc_registrant_code"
    t.string "isrc_year_of_reference"
    t.integer "pictures_count"
    t.integer "events_count"
    t.string "visibility"
    t.index ["slug"], name: "index_videos_on_slug"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
