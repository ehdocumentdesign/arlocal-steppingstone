class InfopageItem < ApplicationRecord

  scope :includes_article,  -> { includes(:article) }
  scope :includes_infopage, -> { includes(:infopage) }
  scope :includes_link,     -> { includes(:link) }
  scope :includes_picture,  -> { includes(picture: :source_uploaded_attachment) }

  scope :infopage_articles, -> { where(infopageable_type: 'Article') }
  scope :infopage_links,    -> { where(infopageable_type: 'Link'   ) }
  scope :infopage_pictures, -> { where(infopageable_type: 'Picture') }

  scope :articles_joinable,   -> { articles.joins(:article).where(articles: { visibility: ['public_indexable', 'public_joinable'] }) }
  scope :articles_released,   -> { articles.joins(:article).where('articles.date_released <= ?', FindPublished.date_today) }
  scope :articles_published,  -> { articles_joinable.articles_released }

  scope :pictures_joinable,   -> { pictures.joins(:picture).where(pictures: { visibility: ['public_indexable', 'public_joinable'] }) }
  scope :pictures_published,  -> { pictures_joinable }

  belongs_to :infopage
  belongs_to :infopageable, polymorphic: true

  belongs_to :article,  -> { where(infopage_items: { infopageable_type: 'Article' } )}, foreign_key: 'infopageable_id', counter_cache: :infopages_count
  belongs_to :link,     -> { where(infopage_items: { infopageable_type: 'Link'    } )}, foreign_key: 'infopageable_id', counter_cache: :infopages_count
  belongs_to :picture,  -> { where(infopage_items: { infopageable_type: 'Picture' } )}, foreign_key: 'infopageable_id', counter_cache: :infopages_count


  protected

  def self.group_options
    [
      {id: '0', order: '0', position: 'top'},
      {id: '1', order: '1', position: 'left'},
      {id: '2', order: '2', position: 'right'}
    ]
  end

  def self.group_options_for_select
    self.group_options.sort_by{ |o| o[:order] }.map{ |o| [o[:position], o[:id]] }
  end


  public

  ### infopage_id

  ### infopage_group

  ### infopage_group_order

  ### infopageable_id

  ### infopageable_type

  def is_article
    infopageable_type == 'Article'
  end

  def is_group(position)
    group = InfopageItem.group_options.select { |o| o[:id] == infopage_group }
    if group == nil
      false
    elsif group == []
      false
    elsif group.any?
      position.to_s == group[0][:position]
    end
  end

  def is_group_left
    is_group(:left)
  end

  def is_group_right
    is_group(:right)
  end

  def is_group_top
    is_group(:top)
  end

  def is_link
    infopageable_type == 'Link'
  end

  def is_picture
    infopageable_type == 'Picture'
  end

  def picture
    if is_picture
      infopageable
    end
  end

  def picture_id
    if is_picture
      infopageable_id
    end
  end

  def title
    self.infopageable.title
  end

  def type_of
    infopageable_type
  end

end
