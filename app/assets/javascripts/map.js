var BD = BD || {}

BD.Map = (function() {

  var coords,
      map;

  function initMap(position) {
    generateCanvas();
    createMap(position);
    setMarker();
  }

  var generateCanvas = function () {
    var mapcanvas = document.createElement('div');
    mapcanvas.id = 'map-frame';
    mapcanvas.style.height = '100%';
    mapcanvas.style.width = '100%';
    mapcanvas.scrolling = "no";

    $("#departures").append(mapcanvas);
  }

  var createMap = function (position) {
    coords = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
    var options = {
      zoom: 15,
      center: coords,
      mapTypeControl: false,
      navigationControlOptions: {
        style: google.maps.NavigationControlStyle.SMALL
      },
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map($("#map-frame")[0], options);
  }

  var setMarker = function () {
    var marker = new google.maps.Marker({
        position: coords,
        map: map,
        title:"You are here!"
    });
  }

  var showDirections = function (destination) {
    var directionsDisplay = new google.maps.DirectionsRenderer({
      map: map
    });

    // Set destination, origin and travel mode.
    var request = {
      destination: destination + ", CA",
      origin: coords,
      travelMode: google.maps.TravelMode.TRANSIT
    };

    // Pass the directions request to the directions service.
    var directionsService = new google.maps.DirectionsService();
    directionsService.route(request, function(response, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        // Display the route on the map.
        directionsDisplay.setDirections(response);
      }
    });
  }


  var run = function() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(initMap);
    } else {
      error('Geo Location is not supported');
    }
  }


  return {
    initMap: initMap,
    run: run,
    showDirections: showDirections,
  }

})();

$(document).ready(function() {
  BD.Map.run();
});
