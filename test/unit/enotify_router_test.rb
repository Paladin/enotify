require 'test_helper'

class EnotifyRouterTest < ActiveSupport::TestCase

  def test_routes_to_incident
    route_test('incident', IncidentParser)
  end
  
  def test_routes_to_service_request
    route_test('service', ServiceRequestParser)
  end
  
  def test_routes_to_permit_record
    route_test('permit', PermitRecordParser)
  end
  
  private
  def route_test(fixture, clazz)
    raw_mail = read_enotify_fixture(fixture).join
    email = TMail::Mail.parse(raw_mail)
    
    router = EnotifyRouter.new('Milwaukee', 'WI')
    report_builder = router.report_builder_for_mail(email)
    
    assert_not_nil report_builder
    assert_kind_of clazz, report_builder.parser
    assert_equal 'Milwaukee', report_builder.city
    assert_equal 'WI', report_builder.state
  end
end
