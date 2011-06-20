var map;
function renderMap(lat,lon)
{
	var latlng = new google.maps.LatLng(lat, lon);
	var myOptions = {
		zoom: 12,
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