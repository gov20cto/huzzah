class Feature
  include Mongoid::Document
  
  field :internal_id, :type => Integer
  field :internal_verified_by, :type => String
  field :internal_last_located, :type => Date
  field :internal_follow_up, :type => String
  field :supervising_physician, :type => String
  field :organization, :type => String
  field :address, :type => String
  field :zip, :type => String
  field :exact_location, :type => String
  field :best_access, :type => String
  field :contact, :type => String
  field :contact_title, :type => String
  field :contact_phone, :type => String
  field :contact_fax, :type => String
  field :contact_email, :type => String
  field :contact_address, :type => String
  field :emergency_contact, :type => String
  field :emergency_phone, :type => String
  field :training_org, :type => String
  field :aed_type, :type => String
  field :number_units, :type => Integer
  field :number_users, :type => Integer
  field :date_implemented, :type => Date
  field :date_validated, :type => DateTime
  field :validated, :type => Boolean

  # each feature can have an optional image
  mount_uploader :image, FeatureImageUploader
  
  # every geographic feature needs to have a location and an address
  field :location, :type => Array, :geo => true, :lat => :latitude, :lng => :longitude
  geo_index :location
end
