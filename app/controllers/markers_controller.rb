class MarkersController < ApplicationController
  respond_to :html,:js
  def index
    @my_home = @logged_in.postition
    if !params[:people_id]
      case params[:type]
      when "share"
        map = @logged_in.map
        @markers = map.markers
      when 'firend_postition'
        @friends = @logged_in.friends
      when 'schedule'
      @plans = @logged_in.plans
		# render :json => @my_home.to_json
      end    
      #render :json => Marker.find_all_by_map_id(map_id).to_json
    end
  end

  def update
    if params[:marker][:id]
      @marker = Marker.find(params[:marker][:id])
      if @marker.update_attributes(params[:marker])
        if @marker.object_type == 'Note'
          render(:template => "notes/create") 
        end
      else
        render :json => {:success=>false} 
      end
	 
    end
  end

  def destroy
    if params[:id]
      marker = Marker.find(params[:id])
      if marker.destroy
        render :json => {:success=>true} 
      else
        render :json => {:success=>false} 
      end
	 
    end
  end


  
  
  
end
