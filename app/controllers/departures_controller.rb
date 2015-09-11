class DeparturesController < ApplicationController

  def index

  end

  def create
    @agent = Agent.new
    @departures = @agent.departures_by_stop_name(params[:agency_name], params[:stop_name])
    respond_to do |format|
      if @departures
        format.js
      else
        format.js { render "shared/flash" }
      end
    end
  end


end
