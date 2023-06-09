module HtmlHeadHelper


  def html_head_favicon_preferred_url(arlocal_settings)
    case arlocal_settings.icon_source_type
    when 'imported'
      source_imported_url(arlocal_settings.icon_filename)
    when 'uploaded'
      url_for(arlocal_settings.icon_image)
    end
  end


  def html_head_meta_charset_tag
    '<meta charset="utf-8">'.html_safe
  end


  def html_head_meta_description(text)
    tag.meta(name: 'description', content: sanitize(text)).html_safe
  end


  def html_head_meta_viewport_tags
    '<meta name="viewport" content="initial-scale=1.0" />'.html_safe
  end


  def html_head_title(arlocal_settings, html_head_title_subtitle)
    title_string = "#{arlocal_settings.artist_name} #{html_head_title_subtitle}"
    result = tag.title(sanitize(title_string)).html_safe
    result.html_safe
  end


  # extends the HTML title appearing in browser title or tab
  def html_head_title_extend!(*subtitle_array)
    content_for :html_head_title_subtitle, (' / ' + subtitle_array.join(' / '))
  end


end
