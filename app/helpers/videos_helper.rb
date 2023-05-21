module VideosHelper


  def video_admin_edit_nav_button(video: nil, category: nil, current_pane: nil)
    button_admin_to_edit_pane(
      current_pane: current_pane,
      target_link: edit_admin_video_path(video.id, pane: category),
      target_pane: category
    )
  end


  def video_admin_button_to_done_editing(video)
    button_admin_to_done_editing admin_video_path(@video.id_admin)
  end


  def video_admin_button_to_edit(video)
    button_admin_to_edit edit_admin_video_path(video.id_admin)
  end


  def video_admin_button_to_edit_next(video, arlocal_settings: nil, current_pane: nil)
    if routing_will_retain_edit_pane(arlocal_settings, current_pane)
      target_link = edit_admin_video_path(video.id_admin, pane: current_pane)
    else
      target_link = edit_admin_video_path(video.id_admin)
    end
    button_admin_to_next(target_link)
  end


  def video_admin_button_to_edit_previous(video, arlocal_settings: nil, current_pane: nil)
    if routing_will_retain_edit_pane(arlocal_settings, current_pane)
      target_link = edit_admin_video_path(video.id_admin, pane: current_pane)
    else
      target_link = edit_admin_video_path(video.id_admin)
    end
    button_admin_to_previous(target_link)
  end


  def video_admin_button_to_index
    button_admin_to_index admin_videos_path
  end


  def video_admin_button_to_new
    button_admin_to_new new_admin_video_path
  end


  def video_admin_button_to_next(video)
    button_admin_to_next admin_video_path(video.id_admin)
  end


  def video_admin_button_to_public(video = nil)
    case video
    when Video
      if video.published
        button_admin_to_public video_path(video.id.public)
      else
        button_admin_to_public_null
      end
    when nil
      button_admin_to_public public_videos_path
    end
  end


  def video_admin_button_to_previous(video)
    button_admin_to_previous admin_video_path(video.id_admin)
  end


  def video_admin_header_nav_buttons
    [ video_admin_button_to_index,
      video_admin_button_to_new
    ].join("\n").html_safe
  end


  def video_event_admin_button_to_new_join_single(video)
    button_admin_to_new_join_single edit_admin_video_path(video.id_admin, pane: :event_join_single)
  end


  def video_keyword_admin_button_to_new_join_single(video)
    button_admin_to_new_join_single edit_admin_video_path(video.id_admin, pane: :keyword_join_single)
  end


  def video_picture_admin_button_to_new_import(video)
    button_admin_to_new_import edit_admin_video_path(video.id_admin, pane: :picture_import)
  end


  def video_picture_admin_button_to_new_join_single(video)
    button_admin_to_new_join_single edit_admin_video_path(video.id_admin, pane: :picture_join_single)
  end


  def video_picture_admin_button_to_new_upload(video)
    button_admin_to_new_upload edit_admin_video_path(video.id_admin, pane: :picture_upload)
  end


  def video_preferred_url(video)
    case video.source_type
    when 'attachment'
      url_for(video.source_uploaded)
    when 'imported'
      source_imported_url(video)
    end
  end


  def video_reference_admin_link(video)
    link_to video.full_title, admin_video_path(video.id_admin)
  end


  def video_statement_events_count(video)
    pluralize video.events_count.to_i, 'events'
  end


  def video_statement_keywords_count(video)
    pluralize video.keywords_count.to_i, 'keyword'
  end


  def video_statement_pictures_count(video)
    pluralize video.pictures_count.to_i, 'picture'
  end


end
