class SourceCatalogSourceUploaded < ActiveRecord::Migration[7.0]


  def up
    rename_column :arlocal_settings, :icon_source_catalog_file_path, :icon_source_imported_file_path
    rename_column :audio, :source_catalog_file_path, :source_imported_file_path
    rename_column :pictures, :source_catalog_file_path, :source_imported_file_path
    up_arlocal_settings
    up_resources
  end


  def down
    rename_column :arlocal_settings, :icon_source_imported_file_path, :icon_source_catalog_file_path
    rename_column :audio, :source_imported_file_path, :source_catalog_file_path
    rename_column :pictures, :source_imported_file_path, :source_catalog_file_path
    down_arlocal_settings
    down_resource
  end




  private


  def applicable_resources
    [
      { name: 'Audio',    object: Audio,   symbol: :audio    },
      { name: 'Pictures', object: Picture, symbol: :pictures },
    ]
  end


  def determine_new_source_type(item_source_type)
    case item_source_type
    when 'attachment'
      'uploaded'
    when 'catalog'
      'imported'
    end
  end


  def determine_old_source_type(item_source_type)
    case item_source_type
    when 'imported'
      'catalog'
    when 'uploaded'
      'attachment'
    end
  end


  def down_arlocal_settings
    say 'ArlocalSettings'
    arlocal_settings = ArlocalSettings.first
    arlocal_settings.icon_source_type = determine_old_source_type(arlocal_settings.icon_source_type)
    say ({icon_source_type: arlocal_settings.icon_source_type}), true
    arlocal_settings.save
  end


  def down_resources
    applicable_resources.each do |resource|
      say resource[:name]
      resource[:object].all.each do |item|
        item.source_type = determine_old_source_type(item.read_attribute(:source_type))
        say ({id: item.id, title: item.title, source_type: item.source_type}), true
        item.save
      end
    end
  end


  def up_arlocal_settings
    say 'ArlocalSettings'
    arlocal_settings = ArlocalSettings.first
    arlocal_settings.icon_source_type = determine_new_source_type(arlocal_settings.icon_source_type)
    say ({icon_source_type: arlocal_settings.icon_source_type}), true
    arlocal_settings.save
  end


  def up_resources
    applicable_resources.each do |resource|
      say resource[:name]
      resource[:object].all.each do |item|
        item.source_type = determine_new_source_type(item.source_type)
        say ({id: item.id, title: item.title, source_type: item.read_attribute(:source_type)}), true
        item.save
      end
    end
  end


end
