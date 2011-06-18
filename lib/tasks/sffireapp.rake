require 'csv'

namespace :sffireapp do
  desc "Import CSV File"
  task :import,[:file] => :environment do |t,args|
    Feature.delete_all
    reader = CSV.open(args[:file])
    reader.each do |row|
      aed = Feature.new
      aed.internal_id = row[0]
      aed.internal_verified_by = row[1]
      aed.supervising_physician = row[2]
      aed.organization = row[3]
      
      # deal with f'd up addresses
      if row[4].nil? and not row[15].nil? then
        row[4] = row[15]
      end
      address = Geocoder::address row[4] + ",San Francisco, CA"
      if address.nil? and not row[4].nil? then
        address = Geocoder::address row[4] 
      end
      if row[4].nil? then 
        puts "Warning: Empty address!"
        puts row
      end
      if address.nil? then
        puts "Warning: Could not normalize address (#{row[0]}): " + row[4]
      else
        location = Geocoder::coordinates address
        aed.location = location
      end
      aed.address = address.nil? ? row[4] : address
      
      aed.zip = row[5]
      aed.exact_location = row[6]
      aed.best_access = row[7]
      aed.internal_last_located = Date.strptime(row[8], '%m/%d/%Y') if not row[8].nil?
      aed.internal_follow_up = row[9]
      aed.contact = row[10]
      aed.contact_title = row[11]
      aed.contact_phone = row[12]
      aed.contact_fax = row[13]
      aed.contact_email = row[14]
      aed.contact_address = row[15]
      aed.emergency_contact = row[16]
      aed.emergency_phone = row[17]
      aed.training_org = row[18]
      aed.aed_type = row[19]
      aed.number_units = row[20]
      aed.number_users = row[21]
      aed.date_implemented = Date.strptime(row[22], '%m/%d/%Y') if not row[22].nil?
      aed.save
    end
  end
end