class Feature
  include Mongoid::Document
  field :address, :type => String
  field :directions, :type => String
end
