class Admin::PicturesController < AdminController

  before_action :verify_picture_file_exists, only: [
    :create_from_import,
    :create_from_import_to_album,
    :create_from_import_to_event
  ]

  around_action :set_datetime_manual_entry_zone_from_params, only: [:create, :update]

  def create
    @picture = PictureBuilder.create(params_picture_permitted)
    if @picture.save
      flash[:notice] = 'Picture was successfuly created.'
      redirect_to edit_admin_picture_path(@picture.id_admin)
    else
      @form_metadata = FormPictureMetadata.new
      flash[:notice] = 'Picture could not be created.'
      render 'new'
    end
  end

  def create_from_import
    @picture = PictureBuilder.create_from_import(params_picture_permitted)
    if @picture.save
      flash[:notice] = 'Picture was successfully imported.'
      redirect_to edit_admin_picture_path(@picture.id_admin)
    else
      @form_metadata = FormPictureMetadata.new
      flash[:notice] = 'Picture could not be imprted.'
      render 'new_import'
    end
  end

  def create_from_import_to_album
    @picture = PictureBuilder.create_from_import_and_join_nested_album(params_picture_permitted)
    if @picture.save
      flash[:notice] = 'Picture was successfully imported.'
      redirect_to edit_admin_picture_path(@picture.id_admin)
    else
      @albums = QueryAlbums.new.order_by_title_asc
      flash[:notice] = 'Picture could not be imported.'
      render 'new_import_to_album'
    end
  end

  def create_from_import_to_event
    @picture = PictureBuilder.create_from_import_and_join_nested_event(params_picture_permitted)
    if @picture.save
      flash[:notice] = 'Picture was successfully imported.'
      redirect_to edit_admin_picture_path(@picture.id_admin)
    else
      @events = QueryEvents.new.order_by_start_time_asc
      flash[:notice] = 'Picture could not be imported.'
      render 'new_import_to_event'
    end
  end

  def create_from_upload
    @picture = PictureBuilder.create_from_upload(params_picture_permitted)
    if @picture.save
      flash[:notice] = 'Picture was successfully uploaded.'
      redirect_to edit_admin_picture_path(@picture.id_admin)
    else
      flash[:notice] = 'Picture could not be uploaded.'
      render 'new_upload_single'
    end
  end

  def create_from_upload_to_album
    @picture = PictureBuilder.create_from_upload_and_join_nested_album(params_picture_permitted)
    if @picture.save
      flash[:notice] = 'Picture was successfully uploaded.'
      redirect_to edit_admin_picture_path(@picture.id_admin)
    else
      @albums = QueryAlbums.new.order_by_title_asc
      flash[:notice] = 'Picture could not be uploaded.'
      render 'new_upload_to_album'
    end
  end

  def create_from_upload_to_event
    @picture = PictureBuilder.create_from_upload_and_join_nested_event(params_picture_permitted)
    if @picture.save
      flash[:notice] = 'Picture was successfully uploaded.'
      redirect_to edit_admin_picture_path(@picture.id_admin)
    else
      @events = QueryEvents.new.order_by_start_time_asc
      flash[:notice] = 'Picture could not be uploaded.'
      render 'new_upload_to_event'
    end
  end

  def destroy
    @picture = QueryPictures.find_admin(params[:id])
    @picture.source_uploaded.purge
    @picture.destroy
    flash[:notice] = 'Picture record was destroyed.'
    redirect_to action: :index
  end

  def edit
    @picture = QueryPictures.find_admin(params[:id])
    @picture_neighbors = QueryPictures.neighborhood_admin(@picture, @arlocal_settings)
    @form_metadata = FormPictureMetadata.new(pane: params[:pane])
  end

  def index
    @pictures = QueryPictures.index_admin(@arlocal_settings, params)
  end

  def index_by_page
    page = QueryPictures.index_admin_by_page(@arlocal_settings, params)
    @pictures = page.collection
    @page_nav_data = page.nav_data
  end

  def new
    @picture = PictureBuilder.build_with_defaults_and_conditional_autokeyword(arlocal_settings: @arlocal_settings)
    @form_metadata = FormPictureMetadata.new
  end

  def new_import_menu
  end

  def new_import_single
    @picture = PictureBuilder.build_with_defaults_and_conditional_autokeyword(arlocal_settings: @arlocal_settings)
  end

  def new_import_to_album
    @picture = PictureBuilder.build_with_defaults_and_conditional_autokeyword(arlocal_settings: @arlocal_settings)
    @albums = QueryAlbums.options_for_select_admin
  end

  def new_import_to_event
    @picture = PictureBuilder.build_with_defaults_and_conditional_autokeyword(arlocal_settings: @arlocal_settings)
    @events = QueryEvents.options_for_select_admin
  end

  def new_upload_menu
  end

  def new_upload_single
    @picture = PictureBuilder.build_with_defaults_and_conditional_autokeyword(arlocal_settings: @arlocal_settings)
  end

  def new_upload_to_album
    @picture = PictureBuilder.build_with_defaults_and_conditional_autokeyword(arlocal_settings: @arlocal_settings)
    @albums = QueryAlbums.options_for_select_admin
  end

  def new_upload_to_event
    @picture = PictureBuilder.build_with_defaults_and_conditional_autokeyword(arlocal_settings: @arlocal_settings)
    @events = QueryEvents.options_for_select_admin
  end

  def purge_source_uploaded
    @picture = QueryPictures.find_admin(params[:id])
    @picture.source_uploaded.purge
    flash[:notice] = 'Attachment purged from picture.'
    redirect_to edit_admin_picture_path(@picture.id_admin, pane: params[:pane])
  end

  def show
    @picture = QueryPictures.find_admin(params[:id])
    @picture_neighbors = QueryPictures.neighborhood_admin(@picture, @arlocal_settings)
  end

  def update
    @picture = QueryPictures.find_admin(params[:id])
    if @picture.update(params_picture_permitted)
      flash[:notice] = 'Picture was successfully updated.'
      redirect_to edit_admin_picture_path(@picture.id_admin, pane: params[:pane])
    else
      @picture_neighbors = QueryPictures.neighborhood_admin(@picture, @arlocal_settings)
      @form_metadata = FormPictureMetadata.new(pane: params[:pane])
      flash[:notice] = 'Picture could not be updated.'
      render 'edit'
    end
  end


  private

  def params_picture_permitted
    params.require(:picture).permit(
      :credits_markup_type,
      :credits_markup_text,
      :datetime_from_manual_entry,
      :datetime_from_manual_entry_zone,
      :datetime_from_manual_entry_year,
      :datetime_from_manual_entry_month,
      :datetime_from_manual_entry_day,
      :datetime_from_manual_entry_hour,
      :datetime_from_manual_entry_minute,
      :datetime_from_manual_entry_second,
      :description_markup_type,
      :description_markup_text,
      :show_can_display_title,
      :source_imported_file_path,
      :source_type,
      :source_uploaded,
      :title_markup_type,
      :title_markup_text,
      :visibility,
      album_pictures_attributes: [
        :id,
        :album_id,
        :_destroy
      ],
      event_pictures_attributes: [
        :id,
        :event_id,
        :_destroy
      ],
      picture_keywords_attributes: [
        :id,
        :keyword_id,
        :_destroy
      ],
      video_pictures_attributes: [
        :id,
        :video_id,
        :_destroy
      ]
    )
  end

  def set_datetime_manual_entry_zone_from_params
    Time.use_zone(params[:picture][:datetime_from_manual_entry_zone]) { yield }
  end

  def verify_picture_file_exists
    filename = helpers.source_imported_file_path(params[:picture][:source_imported_file_path])
    if File.exist?(filename) == false
      flash[:notice] = "File not found: #{filename}"
      redirect_to request.referrer
    end
  end

end
