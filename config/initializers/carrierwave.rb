CarrierWave.configure do |config|
  config.grid_fs_database = Mongoid.database.name
  config.grid_fs_host = Mongoid.database.connection.primary_pool.host
  uri = URI.parse(ENV['MONGOHQ_URL'])
  config.grid_fs_port = uri.port unless uri.port.blank?
  config.grid_fs_username = uri.user unless uri.user.blank?
  config.grid_fs_password = uri.password unless uri.password.blank?
  config.storage = :grid_fs
  config.grid_fs_access_url = "/images"
  config.cache_dir = "uploads"
  config.root = Rails.root.join('tmp')
end
