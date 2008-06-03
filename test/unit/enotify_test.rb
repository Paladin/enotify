require 'test_helper'

class EnotifyTest < ActionMailer::TestCase
  tests Enotify
  def test_receive
  
    raw_mail = read_fixture('receive').join
    assert Enotify.receive(raw_mail)

    incident = Incident.find(:first, :conditions => "address_street1='2776 N BOOTH ST'")
    assert_not_nil incident
    
    mail = incident.enotify_mail
    
    assert_not_nil mail
    assert mail.success
    assert_not_nil mail.incident
  end

end
