class Article < ApplicationRecord


  extend FriendlyId
  extend MarkupParserUtils
  extend Neighborable
  extend Paginateable
  include Seedable

  scope :publicly_indexable, -> { where(visibility: ['public']) }
  scope :publicly_linkable,  -> { where(visibility: ['public', 'unlisted']) }

  friendly_id :slug_candidates, use: :slugged

  has_many :infopage_items, -> { where infopageable_type: 'Article' }, foreign_key: :infopageable_id, dependent: :destroy
  has_many :infopages, through: :infopage_items

  before_validation :strip_whitespace_edges_from_entered_text

  validates :content_parser_id, presence: true
  validates :copyright_parser_id, presence: true


  public


  ### author


  def content_beginning_props
    { parser_id: content_parser_id, text_markup: content_text_markup[0..250].gsub(/[\n\r]+/,' ').concat('…') }
  end


  ### content_parser_id


  def content_props
    { parser_id: content_parser_id, text_markup: content_text_markup }
  end


  ### content_text_markup


  ### copyright_parser_id


  def copyright_props
    { parser_id: copyright_parser_id, text_markup: copyright_text_markup }
  end


  ### copyright_text_markup


  ### created_at


  ### date_released


  def does_have_infopages
    infopages.length > 0
  end


  ### id


  def id_admin
    friendly_id
  end


  def id_public
    friendly_id
  end


  def infopages_sorted
    infopages_sorted_by_order
  end


  def infopages_sorted_by_order
    infopages.to_a.sort_by! { |i| i.index_order }
  end


  def joined_infopages
    infopage_items
  end


  def published
    ['public','unlisted'].include?(visibility)
  end



  def should_generate_new_friendly_id?
    title_changed? ||
    super
  end


  ### slug


  def slug_candidates
    [
      [:title]
    ]
  end


  ### title


  ### updated_at


  ### visibility



  private


  def strip_whitespace_edges_from_entered_text
    strippable_attributes = [
      'author',
      'content_text_markup',
      'copyright_text_markup',
      'title',
    ]
    changed_strippable_attributes = self.changed.select { |v| strippable_attributes.include?(v) }
    changed_strippable_attributes.each do |a|
      stripped_attribute = self.read_attribute(a).to_s.strip
      self.write_attribute(a, stripped_attribute)
    end
  end


end
