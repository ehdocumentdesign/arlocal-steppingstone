class Admin::ArlocalSettingsController < AdminController


  def edit
    @arlocal_settings = QueryArlocalSettings.get
    @form_metadata = FormArlocalSettingsMetadata.new(pane: params[:pane])
  end


  def purge_icon_image
    @arlocal_settings = QueryArlocalSettings.get
    @arlocal_settings.icon_image.purge
    flash[:notice] = 'Icon image purged.'
    redirect_to edit_admin_arlocal_settings_path(@arlocal_settings, pane: :icon)
  end


  def update
    @arlocal_settings = QueryArlocalSettings.get
    if @arlocal_settings.update(params_arlocal_settings_permitted)
      flash[:notice] = 'A&R.local settings were successfully updated.'
      redirect_to edit_admin_arlocal_settings_path(pane: params[:pane])
    else
      @form_metadata = FormArlocalSettingsMetadata.new(pane: params[:pane])
      flash[:notice] = 'A&R.local settings could not be updated.'
      render 'edit'
    end
  end


  def update_from_resource_and_return
    @arlocal_settings = QueryArlocalSettings.get
    if @arlocal_settings.update(params_arlocal_settings_permitted)
      flash[:notice] = 'A&R.local settings were successfully updated.'
      params.delete('filter')
      redirect_to request.referrer
    else
      @form_metadata = FormArlocalSettingsMetadata.new(pane: params[:pane])
      flash[:notice] = 'A&R.local settings could not be updated.'
      render 'edit'
    end
  end



  private


  def params_arlocal_settings_permitted
    params.require(:arlocal_settings).permit(
      :admin_forms_auto_keyword_enabled,
      :admin_forms_auto_keyword_id,
      :admin_forms_edit_slug_field,
      :admin_forms_retain_pane_for_neighbors,
      :admin_forms_selectable_pictures_sorter_id,
      :admin_index_albums_sorter_id,
      :admin_index_audio_sorter_id,
      :admin_index_events_sorter_id,
      :admin_index_isrc_sorter_id,
      :admin_index_pictures_sorter_id,
      :admin_index_videos_sorter_id,
      :artist_content_copyright_year_earliest,
      :artist_content_copyright_year_latest,
      :artist_name,
      :audio_default_isrc_country_code,
      :audio_default_isrc_registrant_code,
      :audio_default_date_released_enabled,
      :audio_default_date_released,
      :marquee_enabled,
      :marquee_parser_id,
      :marquee_text_markup,
      :html_head_public_can_include_meta_description,
      :icon_image,
      :icon_source_imported_file_path,
      :icon_source_type,
      :public_index_albums_sorter_id,
      :public_index_audio_sorter_id,
      :public_index_events_sorter_id,
      :public_index_pictures_sorter_id,
      :public_index_videos_sorter_id,
      :public_nav_can_include_albums,
      :public_nav_can_include_audio,
      :public_nav_can_include_events,
      :public_nav_can_include_info,
      :public_nav_can_include_pictures,
      :public_nav_can_include_stream,
      :public_nav_can_include_videos
     )
   end


end
