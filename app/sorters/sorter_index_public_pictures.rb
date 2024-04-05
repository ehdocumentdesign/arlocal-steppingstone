class SorterIndexPublicPictures


  extend InactiveRecordSingleton
  include Rails.application.routes.url_helpers


  DATA = [
    {
      # id: 0,
      id: 'datetime_asc',
      description: 'by date/time cascade (old - new)',
      symbol: :datetime_asc
    },
    {
      # id: 1,
      id: 'datetime_desc',
      description: 'by date/time cascade (new - old)',
      symbol: :datetime_desc
    },
    {
      # id: 2,
      id: 'filepath_asc',
      description: 'by filepath (ascending)',
      symbol: :filepath_asc
    },
    {
      # id: 3,
      id: 'filepath_desc',
      description: 'by filepath (descending)',
      symbol: :filepath_desc
    },
    {
      # id: 4,
      id: 'title_asc',
      description: 'by title (ascending)',
      symbol: :title_asc
    },
    {
      # id: 5,
      id: 'title_desc',
      description: 'by title (descending)',
      symbol: :title_desc
    }
  ]


  attr_reader :id, :description, :symbol


  def initialize(sorter)
    if sorter
      @id = sorter[:id]
      @description = sorter[:description]
      @symbol = sorter[:symbol]
    end
  end



  public


  # def url
  #   case @symbol
  #   when :datetime_asc
  #     public_pictures_path({filter: 'datetime_asc'})
  #   when :datetime_desc
  #     public_pictures_path({filter: 'datetime_desc'})
  #   when :filepath_asc
  #     public_pictures_path({filter: 'filepath_asc'})
  #   when :filepath_desc
  #     public_pictures_path({filter: 'filepath_desc'})
  #   when :title_asc
  #     public_pictures_path({filter: 'title_asc'})
  #   when :title_desc
  #     public_pictures_path({filter: 'title_desc'})
  #   else
  #     public_pictures_path
  #   end
  # end


  def url
    if @id
      public_pictures_path({filter: @id})
    else
      public_pictures_path
    end
  end

end
