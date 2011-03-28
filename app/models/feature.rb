class Feature
  include Mongoid::Document
  
  # every geographic feature needs to have a location and an address
  field :location, :type => Array, :geo => true, :lat => :latitude, :lng => :longitude
  geo_index :location
  
  field :address, :type => String

  # each feature can have an optional image
  mount_uploader :image, FeatureImageUploader
  
  # features are submitted by users
  field :submitter, :type => String
  
end
