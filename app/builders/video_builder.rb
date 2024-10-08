class VideoBuilder

  require 'mediainfo'
  attr_reader :metadata, :video

  def initialize(**args)
    arlocal_settings = (ArlocalSettings === args[:arlocal_settings]) ? args[:arlocal_settings] : nil
    video = (Video === args[:video]) ? args[:video] : Video.new

    @arlocal_settings = arlocal_settings
    @metadata = nil
    @video = video
  end


  protected

  def self.build(**args)
    builder = new(**args)
    yield(builder)
    builder.video
  end

  def self.build_with_defaults(**args)
    self.build(**args) do |b|
      b.assign_default_attributes
    end
  end

  def self.build_with_defaults_and_conditional_autokeyword(**args)
    self.build(**args) do |b|
      b.assign_default_attributes
      b.conditionally_build_autokeyword
    end
  end

  def self.create(video_params, **args)
    self.build(**args) do |b|
      b.assign_default_attributes
      b.assign_given_attributes(video_params)
    end
  end


  public

  def assign_default_attributes
    @video.assign_attributes(params_default)
  end

  def assign_given_attributes(video_params)
    @video.assign_attributes(video_params)
  end

  def conditionally_build_autokeyword
    if @arlocal_settings.admin_forms_new_will_have_autokeyword
      @video.video_keywords.build(keyword_id: @arlocal_settings.admin_forms_autokeyword_id)
    end
  end

  def determine_metadata
    if metadata_is_not_assigned
      determine_metadata_by_source_type
    end
  end

  def determine_metadata_by_source_type
    case @video.source_type.to_sym
    when :uploaded
      determine_metadata_from_uploaded
    when :imported
      determine_metadata_from_imported
    end
  end

  def determine_metadata_from_uploaded
    if @video.recording != nil
      @metadata = MediaInfo.from(@video.recording.blob)
    end
  end

  def determine_metadata_from_imported
    if File.exist?(imported_video_filesystem_path(@video))
      @metadata = MediaInfo.from(imported_video_filesystem_path(@video))
    end
  end

  def metadata_is_assigned
    MediaInfo::Tracks === @metadata
  end

  def metadata_is_not_assigned
    metadata_is_assigned == false
  end

  def read_source_dimensions
    determine_metadata
    @video.source_dimension_height = @metadata.video.height
    @video.source_dimension_width = @metadata.video.width
  end


  private

  def params_default
    {
      copyright_markup_type: 'string',
      description_markup_type: 'plaintext',
      isrc_country_code: params_default_isrc_country_code,
      isrc_registrant_code: params_default_isrc_registrant_code,
      personnel_markup_type: 'plaintext',
      visibility: 'admin_only'
    }
  end

  def params_default_isrc_country_code
    if @arlocal_settings
      @arlocal_settings.audio_default_isrc_country_code
    end
  end

  def params_default_isrc_registrant_code
    if @arlocal_settings
      @arlocal_settings.audio_default_isrc_registrant_code
    end
  end

end
