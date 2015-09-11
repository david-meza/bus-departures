var BD = BD || {}

BD.Map = (function() {

  function initMap(position) {
    var mapcanvas = document.createElement('div');
    mapcanvas.id = 'map-frame';
    mapcanvas.style.height = '100%';
    mapcanvas.style.width = '100%';
    mapcanvas.scrolling = "no";

    $("#departures").append(mapcanvas);

    var coords = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
    var options = {
      zoom: 15,
      center: coords,
      mapTypeControl: false,
      navigationControlOptions: {
        style: google.maps.NavigationControlStyle.SMALL
      },
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map($("#map-frame")[0], options);

    var marker = new google.maps.Marker({
        position: coords,
        map: map,
        title:"You are here!"
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
    run: run
  }

})();

$(document).ready(function() {
  BD.Map.run();
});
