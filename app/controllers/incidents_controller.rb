class IncidentsController < ApplicationController
  before_filter :login_required
  layout 'default'
  
  # GET /incidents
  # GET /incidents.xml
  def index
    if (params[:month] && params[:year])
      objects = instance_variable_set("@#{controller_name}", current_model.in_month(params[:month], params[:year]))
    else
      objects = instance_variable_set("@#{controller_name}", current_model.find(:all))
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.atom
      format.xml  { render :xml => objects }
      format.ics { render :text => build_calendar(objects).to_ical }
    end
  end

  # GET /incidents/recent
  # GET /incidents/recent.xml
  def recent
    objects = instance_variable_set("@#{controller_name}", current_model.recent)

    respond_to do |format|
      format.html { render :action => "index" }
      format.atom { render :action => "index" }
      format.xml  { render :xml => objects }
      format.ics { render :text => build_calendar(objects).to_ical }
    end
  end
  
  # GET /incidents/search/theft
  # GET /incidents/search/theft.xml
  def search
    terms = params[:terms].join(" ")
    objects = instance_variable_set("@#{controller_name}", current_model.find_by_contents(terms))

    respond_to do |format|
      format.html { render :action => "index" }
      format.atom { render :action => "index" }
      format.xml  { render :xml => objects }
    end
  end

  # GET /incidents/1
  # GET /incidents/1.xml
  def show
    object = instance_variable_set("@#{controller_name.singularize}", current_model.find(params[:id]))

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => object }
    end
  end

  # GET /incidents/new
  # GET /incidents/new.xml
  def new
    object = instance_variable_set("@#{controller_name.singularize}", current_model.new)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => object }
    end
  end

  # GET /incidents/1/edit
  def edit
    instance_variable_set("@#{controller_name.singularize}", current_model.find(params[:id])) 
  end

  # POST /incidents
  # POST /incidents.xml
  def create
    object = instance_variable_set("@#{controller_name.singularize}", current_model.create(params_hash))

    respond_to do |format|
      if object.save
        flash[:notice] = ' was successfully created.'
        format.html { redirect_to(object) }
        format.xml  { render :xml => object, :status => :created, :location => object }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => object.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /incidents/1
  # PUT /incidents/1.xml
  def update
    object = instance_variable_set("@#{controller_name.singularize}", current_model.find(params[:id])) 

    respond_to do |format|
      if eval("@#{controller_name.singularize}").update_attributes(params_hash)
        flash[:notice] = ' was successfully updated.'
        format.html { redirect_to(object) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => object.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.xml
  def destroy
    current_model.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to :action=>:index }
      format.xml  { head :ok }
    end
  end

  private
  def current_model
      Object.const_get controller_name.classify
  end
 
  def params_hash
    params[controller_name.singularize.to_sym]
  end

  def build_calendar(incidents)
    cal = Icalendar::Calendar.new
    cal.custom_property("METHOD","PUBLISH")    # Outlook hack?
    incidents.each { |i| cal.add_event(i.to_ical) }
    cal 
  end

end
