module VisibilityHelper


  def visibilities
    [
      # {
      #   id: 0,
      #   icon: icon_private,
      #   title: 'private',
      #   description: "#{icon_private} Private; Unavailable".html_safe
      # },
      {
        id: 1,
        icon: icon_private,
        title: 'private',
        description: "#{icon_private} private".html_safe
      },
      {
        id: 2,
        icon: icon_published,
        title: 'unlisted',
        description: "#{icon_published} unlisted".html_safe
      },
      {
        id: 3,
        icon: icon_published,
        title: 'public',
        description: "#{icon_published} public".html_safe
      }
    ]
  end


  def visibility_description(title)
    visibilities.select { |v| v[:title] == title }[0][:description]
  end


  def visibility_icon(title)
    visibilities.select { |v| v[:title] == title }[0][:icon]
  end


  def visibility_options_for_select
    options = []
    visibilities.sort_by { |v| v[:id] }.reverse.each do |vis|
      options << [vis[:description], vis[:title]]
    end
    options
  end


end
