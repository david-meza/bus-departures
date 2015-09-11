class Agent

  def initialize
    @client = SFBATransitAPI.client ENV['SFBAY511']
  end

  def get_stops(a_name, rt_code, dir)
    stops = @client.get_stops_for_route(agency_name: "SF-MUNI", route_code: "19", route_direction_code: "Outbound")
    @stops = stops[0]["routes"][0]["route_directions"][0]["stops"]
  end

  def find_stop(stop_name)
    @stops.find { |stop| stop["name"] =~ /#{Regexp.quote(stop_name)}/ }
  end

  def get_next_departures(stop_code)
    @client.get_next_departures_by_stop_code(stop_code)[0]["routes"][0]["route_directions"][0]["stops"][0]["departure_times"]
  end

  def get(methods, opts = {})
    response = @client.get(methods, opts)
    @client.parse(response)
  end

  def departures_by_stop_name(agency_name, stop_name)
    response = get(:get_next_departures_by_stop_name, { agency_name: agency_name, stop_name: stop_name })
    info = {}
    unless response.empty?
      response[0]["routes"].each do |route|
        info[route["name"]] = { destination: route["stops"][0]["name"], departure_times: route["stops"][0]["departure_times"] }
      end
      return info
    end
    nil
  end

end
