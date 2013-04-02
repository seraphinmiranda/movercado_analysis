class StatisticsController < ApplicationController
	def index
		respond_to do |format|
      			format.html # index.html.erb
     			format.json { head :ok }
    	end
	end

	def top10_activista_by_week
		@week_data = Interaction.top_by_week({:roles => "activista", :top_order => "DESC", :n_results => 10, :day_of_the_week  => params[:day_of_the_week]}) 
		respond_to do |format|
      		format.html { head :ok }	
      		format.json { render json: { week_data: @week_data }}
      	end
	end
end

