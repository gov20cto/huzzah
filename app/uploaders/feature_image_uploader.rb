# encoding: utf-8

class FeatureImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  version :thumb do
   
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
