class QueryStreams


  protected

  def self.find_admin(id)
    Stream.friendly.find(id)
  end

  def self.find_public(id)
    Stream.publicly_linkable.friendly.find(id)
  end

  def self.index_admin
    new.index_admin
  end

  def self.neighborhood_admin(stream)
    new.neighborhood_admin(stream)
  end

  def self.options_for_select_admin
    Stream.select(:id, :title)
  end


  public

  def initialize(**args)
    @arlocal_settings = args[:arlocal_settings]
    @params = args[:params] ? args[:params] : {}
  end

  def index_admin
    Stream.all
  end

  def neighborhood_admin(stream, distance: 1)
    Stream.neighborhood(stream, collection: index_admin, distance: distance)
  end

end
