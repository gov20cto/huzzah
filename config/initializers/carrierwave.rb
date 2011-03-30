CarrierWave.configure do |config|
  config.grid_fs_database = Mongoid.database.name
  config.grid_fs_host = Mongoid.database.connection.primary_pool.host
  #config.grid_fs_port = Mongoid.database.port
  #config.grid_fs_username = Mongoid.database.username
  #config.grid_fs_password = Mongoid.database.password
  config.storage = :grid_fs
  config.grid_fs_access_url = "/images"
  config.cache_dir = "uploads"
  config.root = Rails.root.join('tmp')
end
