module FormHelper


  ### TODO: Too confusing.
  # def form_message_link_inline_text
  #   'Text entered here is used when a page link (such as on the info page) displays as address-only. In such cases, the address itself will be used for the address inline text if this field remains blank.'
  # end


  def form_message_picture_datetime_cascade
    'The <em>datetime cascade</em> option will order pictures based on the first available data, choosing from 1) a manually-entered date/time, 2) the date/time from image metadata, 3) the date/time from the picture file.'.html_safe
  end


  ### TODO: Obsolete
  # def form_message_slug_description
  #   'A&R.local will automatically generate a URL-friendly "slug" for albums, events, pictures, and keywords. This option, when checked, will enable a text field to edit the "slug" of a resource.'
  # end


  ### TODO: Obsolete
  # def form_label_without_top_level(symbol)
  #   symbol.to_s.split('_')[1..-1].join('_').to_sym
  # end


end
