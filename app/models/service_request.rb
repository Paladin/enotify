class ServiceRequest < ActiveRecord::Base
  belongs_to :enotify_mail
  belongs_to :address
  belongs_to :geo_location

  # tax_key, record_number, complaint, time
end
