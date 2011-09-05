$(function() {
	$(activeTab).addClass('active');
});

var map;
var loadedMarkers = new Array();
function renderMap(lat,lon,zoom,sensor)
{
	var bounds_changed = false;
	var initialized = false;
	var latlng = new google.maps.LatLng(37.745360538424284, -122.43467206259766);
	var myOptions = {
		zoom: zoom,
		center: latlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		panControl: false,
		zoomControl: true,
		zoomControlOptions: { position: google.maps.ControlPosition.LEFT_TOP },
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

	google.maps.event.addListener(map, 'bounds_changed', function() {
		if(initialized) {
			bounds_changed=true;
		} else {
			initialized=true;
			addPads(map.getBounds());
		}
	});
	
	setInterval(function() {
		if(bounds_changed) {
			bounds_changed=false;
			addPads(map.getBounds());
		}
	},2000);
}

function addPads(b)
{
	// load aed data
	$.ajax({
		url: "/features.json?box=" + b.toUrlValue(),
		context: document.body,
		success: function(data)
		{
			for(i = 0; i<data.length;i++)
			{
				if(typeof data[i].location == "undefined") continue
				if(typeof loadedMarkers[data[i]._id] == "undefined") {
					var latlng = new google.maps.LatLng(data[i].location[0], data[i].location[1]);
					var icon = null;
					if(data[i].validated) {
						icon = 'http://www.google.com/intl/en_us/mapfiles/ms/icons/green-dot.png';
					}
					var m = new google.maps.Marker({
						icon: icon,
						position: latlng, 
						map: map, 
						title: data[i].address,
						feature_id: data[i]._id
					});
					google.maps.event.addListener(m,'click',function() 
					{
						displayModal(this.feature_id);
					});	
					loadedMarkers[data[i]._id] = m;
				}
			}
		}
	});
}

function displayModal(feature_id)
{
	$.ajax({
		url: "/features/" + feature_id,
		context: document.body,
		success: function(data)
		{
			$("#modal_loader").html(data);
			$("#modal_loader .close").click(function() { $("#modal_loader").html(''); });
			$("#modal_loader #close_button").click(function() { $("#modal_loader").html(''); });
			$("#modal_loader #mask").click(function() { $("#modal_loader").html(''); });
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