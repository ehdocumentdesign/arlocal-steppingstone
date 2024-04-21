class Admin::AudioController < AdminController


  before_action :verify_audio_file_exists, only: [
    :create_from_import,
    :create_from_import_to_album,
    :create_from_import_to_event
  ]


def create
    @audio = AudioBuilder.create(params_audio_permitted, arlocal_settings: @arlocal_settings)
    if @audio.save
      flash[:notice] = 'Audio was successfully created.'
      redirect_to edit_admin_audio_path(@audio.id_admin)
    else
      @form_metadata = FormAudioMetadata.new
      if @arlocal_settings.admin_forms_autokeyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      flash[:notice] = 'Audio could not be created.'
      render 'new'
    end
  end


  def create_from_import
    @audio = AudioBuilder.create_from_import(params_audio_permitted, arlocal_settings: @arlocal_settings)
    if @audio.save
      flash[:notice] = 'Audio was successfully imported.'
      redirect_to edit_admin_audio_path(@audio.id_admin)
    else
      flash[:notice] = 'Audio could not be imported.'
      @form_metadata = FormAudioMetadata.new
      if @arlocal_settings.admin_forms_autokeyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      render 'new'
    end
  end


  def create_from_import_to_album
    @audio = AudioBuilder.create_from_import_and_join_nested_album(params_audio_permitted, arlocal_settings: @arlocal_settings)
    if @audio.save
      flash[:notice] = 'Audio was successfully imported.'
      redirect_to edit_admin_audio_path(@audio.id_admin)
    else
      if @arlocal_settings.admin_forms_autokeyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @albums = QueryAlbums.options_for_select_admin
      flash[:notice] = 'Audio could not be imported.'
      render 'new_import_to_album'
    end
  end


  def create_from_import_to_event
    @audio = AudioBuilder.create_from_import_and_join_nested_event(params_audio_permitted, arlocal_settings: @arlocal_settings)
    if @audio.save
      flash[:notice] = 'Audio was successfully imported.'
      redirect_to edit_admin_audio_path(@audio.id_admin)
    else
      if @arlocal_settings.admin_forms_autokeyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @events = QueryEvents.options_for_select_admin
      flash[:notice] = 'Audio could not be imported.'
      render 'new_import_to_event'
    end
  end


  def create_from_upload
    @audio = AudioBuilder.create_from_upload(params_audio_permitted, arlocal_settings: @arlocal_settingss)
    if @audio.save
      flash[:notice] = 'Audio was successfully uploaded.'
      redirect_to edit_admin_audio_path(@audio.id_admin)
    else
      if @arlocal_settings.admin_forms_autokeyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      flash[:notice] = 'Audio could not be uploaded.'
      render 'new_upload_single'
    end
  end


  def create_from_upload_to_album
    @audio = AudioBuilder.create_from_upload_and_join_nested_album(params_audio_permitted, arlocal_settings: @arlocal_settings)
    if @audio.save
      flash[:notice] = 'Audio was successfully uploaded.'
      redirect_to edit_admin_audio_path(@audio.id_admin)
    else
      if @arlocal_settings.admin_forms_autokeyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @albums = QueryAlbums.options_for_select_admin
      flash[:notice] = 'Audio could not be uploaded.'
      render 'new_upload_to_album'
    end
  end


  def create_from_upload_to_event
    @audio = AudioBuilder.create_from_upload_and_join_nested_event(params_audio_permitted)
    if @audio.save
      flash[:notice] = 'Audio was successfully uploaded.'
      redirect_to edit_admin_audio_path(@audio.id_admin)
    else
      if @arlocal_settings.admin_forms_autokeyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @events = QueryEvents.options_for_select_admin
      flash[:notice] = 'Audio could not be uploaded.'
      render 'new_upload_to_event'
    end
  end


  def destroy
    @audio = QueryAudio.find_admin(params[:id])
    @audio.source_uploaded.purge
    @audio.destroy
    flash[:notice] = 'Audio was destroyed.'
    redirect_to action: :index
  end


  def edit
    @audio = QueryAudio.find_admin(params[:id])
    @audio_neighbors = QueryAudio.neighborhood_admin(@audio, @arlocal_settings)
    @form_metadata = FormAudioMetadata.new(pane: params[:pane])
  end


  def index
    @audio = QueryAudio.index_admin(@arlocal_settings, params)
  end


  def new
    @audio = AudioBuilder.build_with_defaults(arlocal_settings: @arlocal_settings)
    @form_metadata = FormAudioMetadata.new
    if @arlocal_settings.admin_forms_autokeyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      @audio.audio_keywords.build(keyword_id: @auto_keyword.keyword_id)
    end
  end


  def new_import_menu
  end


  def new_import_single
    @audio = AudioBuilder.build_with_defaults(arlocal_settings: @arlocal_settings)
    if @arlocal_settings.admin_forms_autokeyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def new_import_to_album
    @audio = AudioBuilder.build_with_defaults(arlocal_settings: @arlocal_settings)
    @albums = QueryAlbums.options_for_select_admin
    if @arlocal_settings.admin_forms_autokeyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def new_import_to_event
    @audio = AudioBuilder.build_with_defaults(arlocal_settings: @arlocal_settings)
    @events = QueryEvents.options_for_select_admin
    if @arlocal_settings.admin_forms_autokeyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def new_upload_menu
  end


  def new_upload_single
    @audio = AudioBuilder.build_with_defaults(arlocal_settings: @arlocal_settings)
    if @arlocal_settings.admin_forms_autokeyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def new_upload_to_album
    @audio = AudioBuilder.build_with_defaults(arlocal_settings: @arlocal_settings)
    @albums = QueryAlbums.options_for_select_admin
    if @arlocal_settings.admin_forms_autokeyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def new_upload_to_event
    @audio = AudioBuilder.build_with_defaults(arlocal_settings: @arlocal_settings)
    @events = QueryEvents.options_for_select_admin
    if @arlocal_settings.admin_forms_autokeyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def purge_source_uploaded
    @audio = QueryAudio.find_admin(params[:id])
    @audio.source_uploaded.purge
    flash[:notice] = 'Attachment purged from audio.'
    redirect_to edit_admin_audio_path(@audio.id_admin, pane: :source)
  end


  def refresh_id3
    # @audio = AudioBuilder.refresh_id3(params_audio_permitted)
    # if @audio.save
    #   flash[:notice] = "Audio was successfully updated."
    #   redirect_to edit_admin_audio_path(@audio.id_admin, pane: 'id3')
    # else
    #   @audio_neighbors = QueryAudio.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@audio)
    #   @form_metadata = FormAudioMetadata.new(pane: params[:pane])
    #   flash[:notice] = "Audio could not be updated."
    #   render 'edit'
    # end
  end


  def show
    @audio = QueryAudio.find_admin(params[:id])
    @audio_neighbors = QueryAudio.neighborhood_admin(@audio, @arlocal_settings)
  end


  def update
    @audio = QueryAudio.find_admin(params[:id])
    if @audio.update_and_recount_joined_resources(params_audio_permitted)
      flash[:notice] = 'Audio was successfully updated.'
      redirect_to edit_admin_audio_path(@audio.id_admin, pane: params[:pane])
    else
      @audio_neighbors = QueryAudio.neighborhood_admin(@audio, @arlocal_settings)
      @form_metadata = FormAudioMetadata.new(pane: params[:pane])
      flash[:notice] = 'Audio could not be updated.'
      render 'edit'
    end
  end



  private



  def ensure_index_sorting
    if params[:filter] == nil
      params[:filter] = SorterIndexAdminAudio.find(@arlocal_settings.admin_index_audio_sorter_id).symbol
    end
  end


  def params_audio_permitted
    params.require(:audio).permit(
      :artist,
      :audio_artist,
      :composer,
      :copyright_markup_type,
      :copyright_markup_text,
      :date_released,
      :description_markup_type,
      :description_markup_text,
      :duration_hrs,
      :duration_mins,
      :duration_secs,
      :duration_mils,
      :isrc_country_code,
      :isrc_designation_code,
      :isrc_registrant_code,
      :isrc_year_of_reference,
      :musicians_markup_type,
      :musicians_markup_text,
      :personnel_markup_type,
      :personnel_markup_text,
      :source_imported_file_path,
      :source_type,
      :source_uploaded,
      :source_url,
      :subtitle,
      :title,
      :visibility,
      album_audio_attributes: [
        :id,
        :album_id,
        :album_order,
        :_destroy
      ],
      audio_keywords_attributes: [
        :id,
        :keyword_id,
        :_destroy
      ],
      event_audio_attributes: [
        :id,
        :event_id,
        :event_order,
        :_destroy
      ]
    )
  end


  def verify_audio_file_exists
    filename = helpers.source_imported_file_path(params[:audio][:source_imported_file_path])
    if File.exist?(filename) == false
      flash[:notice] = "File not found: #{filename}"
      redirect_to request.referrer
    end
  end


end



# def index_by_album
#   @album = QueryAlbums.new.find_by_slug(params[:album_id])
#   @audio = QueryAudio.new.admin_index_by_album(@album)
#   render action: :index
# end
#
#
# def index_by_keyword
#   @keyword = Keyword.find_by_slug!(params[:keyword_id])
#   @audio = QueryAudio.new.admin_index_by_keyword(@keyword)
#   render action: :index
# end
#
#
# def index_without_albums
#   @audio = QueryAudio.new.index_no_albums
#   render action: :index
# end
#
#
# def index_without_keywords
#   @audio = QueryAudio.new.index_no_keywords
#   render action: :index
# end
#
#
