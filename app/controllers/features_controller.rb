class FeaturesController < ApplicationController
  respond_to :html, :xml, :json
  # GET /features
  # GET /features.xml
  def index
    box = params[:box].nil? ? nil : params[:box].split(',')
    unless box.nil? then
      box = [ [box[0],box[1]], [box[2],box[3]] ]
      puts box
      @features = Feature.where(:location.within_box => box)
    end

    respond_with @features
  end

  # GET /features/1
  # GET /features/1.xml
  def show
    @feature = Feature.find(params[:id])
    respond_with @feature do |format|
      format.html { render :layout => false }
    end
  end

  # GET /features/new
  # GET /features/new.xml
  def new
    @feature = Feature.new
    respond_with @feature
  end

  # GET /features/1/edit
  def edit
    @feature = Feature.find(params[:id])
    respond_with @feature
  end

  # POST /features
  # POST /features.xml
  def create
    @feature = Feature.new(params[:feature])

    respond_to do |format|
      if @feature.save
        format.html { redirect_to(edit_feature_path(@feature), :notice => 'AED was successfully created.') }
        format.xml  { render :xml => @feature, :status => :created, :location => @feature }
        format.json { render :json => @feature, :status => :created, :location => @feature }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feature.errors, :status => :unprocessable_entity }
        format.json { render :json => @feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /features/1
  # PUT /features/1.xml
  def update
    @feature = Feature.find(params[:id])

    respond_to do |format|
      if @feature.update_attributes(params[:feature])
        format.html { redirect_to(edit_feature_path(@feature), :notice => 'AED was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /features/1
  # DELETE /features/1.xml
  def destroy
    @feature = Feature.find(params[:id])
    @feature.destroy

    respond_to do |format|
      format.html { redirect_to(features_url) }
      format.xml  { head :ok }
    end
  end
end
