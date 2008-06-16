require 'hpricot'
Hpricot::XChar::PREDEFINED_U.merge!({"&nbsp;" => 32})

class EnotifyRouter
  
  def initialize(city, state)
    @crime_reports = CityReports.new(CrimeParser.new, GeoLocationLookup.new, city, state)
    @permit_reports = CityReports.new(PermitRecordParser.new, GeoLocationLookup.new, city, state)
    @service_reports = CityReports.new(ServiceRequestParser.new, GeoLocationLookup.new, city, state)
    @recording_reports = CityReports.new(RecordingAppParser.new, GeoLocationLookup.new, city, state)
    @violation_reports = CityReports.new(ViolationRecordParser.new, GeoLocationLookup.new, city, state)
  end
  
  # original_text, clean_text, title, success
  
  def create_from_raw_mail(raw_mail)
    email = TMail::Mail.parse(raw_mail)
    create_from_mail(email)
  end
  
  def create_from_mail(email)
    report_builder = report_builder_for_mail(email)

    # remove any HTML tags and random sets of blank spaces
    doc = Hpricot.parse(email.body.gsub("><", ">\n<"), :xhtml_strict => true)
    cleaned_body = doc.inner_text.split(' ').join(' ')

    enotify_mail = EnotifyMail.new(:original_text => email.body, :clean_text => cleaned_body, :title => email.subject)

    begin
      report = report_builder.build_report(cleaned_body)
      enotify_mail.success = true
    rescue Exception => ex
      Rails.logger.error(cleaned_body)
      enotify_mail.success = false
      enotify_mail.parse_error = ex
      Rails.logger.error(ex)
    end
    report.enotify_mail = enotify_mail if report
    report
  end
  
  def report_builder_for_mail(email)
    if email.subject =~ /new service request/
      return @service_reports
    elsif email.subject =~ /new permit record/
      return @permit_reports
    elsif email.subject =~ /new recording application/
      return @recording_reports
    elsif email.subject =~ /new violation record/
      return @violation_reports
    elsif email.subject =~ /Crime Incident/
      return @crime_reports
    else
      raise Exception.new, "Unknown enotify"
    end
  end
end
