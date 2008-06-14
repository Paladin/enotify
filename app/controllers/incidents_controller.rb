class IncidentsController < ApplicationController
  before_filter :login_required
  layout 'default'
  
  # GET /incidents
  # GET /incidents.xml
  def index
    if (params[:month] && params[:year])
      @incidents = Incident.find_by_month_and_year(params[:month], params[:year])
    else
      @incidents = Incident.find(:all)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.atom
      format.xml  { render :xml => @incidents }
    end
  end
  
end
