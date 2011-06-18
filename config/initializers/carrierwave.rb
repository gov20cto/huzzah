CarrierWave.configure do |config|
  config.grid_fs_database = Mongoid.database.name
  config.grid_fs_host = Mongoid.database.connection.primary_pool.host
  uri = ENV['MONGOHQ_URL'].nil? ? URI.parse("mongodb://localhost:27017") : URI.parse(ENV['MONGOHQ_URL']) 
  #uri = Mongoid.database
  config.grid_fs_port = uri.port unless uri.port.blank?
  config.grid_fs_username = uri.user unless uri.user.blank?
  config.grid_fs_password = uri.password unless uri.password.blank?
  config.storage = :grid_fs
  config.grid_fs_access_url = "/images"
  config.cache_dir = "uploads"
  config.root = Rails.root.join('tmp')
end
