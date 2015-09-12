class DeparturesController < ApplicationController

  def index

  end

  def create
    @agent = Agent.new
    @destination = params[:stop_name]
    respond_to do |format|
      if params[:agency_name].length > 1 && @destination.length > 1
        @departures = @agent.departures_by_stop_name(params[:agency_name], @destination)
        if @departures
          format.js
        else
          flash[:alert] = "We processed your request but received no results"
          format.js { render "shared/flash" }
        end
      else
        flash[:alert] = "Please fill out both input fields"
        format.js { render "shared/flash" }
      end
    end
  end

  def get_agencies
    @agent = Agent.new
    @agencies = @agent.get_agencies
    respond_to do |format|
      format.js { render :show_agencies }
    end
  end


end
