var map;
var zoom = 15;
function renderMap(lat,lon,sensor)
{
	var latlng = new google.maps.LatLng(lat, lon);
	var myOptions = {
		zoom: zoom,
		center: latlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		panControl: false,
		zoomControl: true,
		mapTypeControl: false,
		scaleControl: true,
		streetViewControl: false,
		overviewMapControl: true
	};
	map = new google.maps.Map(document.getElementById("map_canvas"),
	myOptions);
	
	// if we got our data from a geolocator, throw up the "blue ball"
	if(sensor)
	{
		addSensor(lat,lon);
	}
	
	// load aed data
	$.ajax({
		url: "/features.json",
		context: document.body,
		success: function(data)
		{
			var bounds = new google.maps.LatLngBounds();
			for(i = 0; i<data.length;i++)
			{
				if(typeof data[i].location == "undefined") continue
				
				var latlng = new google.maps.LatLng(data[i].location[0], data[i].location[1]);
				var m = new google.maps.Marker(
					{
						position: latlng, 
						map: map, 
						title: data[i].address,
						feature_id: data[i]._id
					});
				google.maps.event.addListener(m,'click',function() 
					{
						window.location = "/features/" + this.feature_id;
					});
				bounds.extend(latlng);
				
			}
			//map.setCenter(bounds.getCenter(), map.fitBounds(bounds));
		}
	});
}

function addSensor(lat,lon) {
	var image = new google.maps.MarkerImage('/images/blueball.png',
		new google.maps.Size(16, 16),
		new google.maps.Point(0,0),
		new google.maps.Point(7, 7));


	var sensor_loc = new google.maps.LatLng(lat, lon);
	var marker = new google.maps.Marker({
		position: sensor_loc,
		map: map,
		icon: image,
		title: "You are here.",
		zIndex: 1000
	});

}