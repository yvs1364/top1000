import mapboxgl from 'mapbox-gl';

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `url('${marker.image_url}')`;
    element.style.backgroundSize = 'contain';
    element.style.width = '40px';
    element.style.height = '40px';

    new mapboxgl.Marker(element)
    .setLngLat([ marker.lng, marker.lat ])
    .setPopup(popup)
    .addTo(map)
  });
};
const addUserMarkerToMap = (map, userMarkerPosition) =>{
  const userMar = document.createElement('div');

  userMar.className = 'user_marker';
  userMar.style.backgroundImage = `url('${userMarkerPosition.image_url}')`;
  userMar.style.backgroundSize = 'contain';
  userMar.style.width = '20px';
  userMar.style.height = '20px';

  new mapboxgl.Marker(userMar)
  .setLngLat([ userMarkerPosition.lng, userMarkerPosition.lat ])
  .addTo(map)

  // map.addControl(
  //   new mapboxgl.GeolocateControl({
  //     positionOptions: {
  //       enableHighAccuracy: true
  //     },
  //     trackUserLocation: true
  //   })
  // );
};

const centerMapToUser = (map, userPosition) =>{
map.jumpTo({center: userPosition, zoom: 14.5});
}

const initMapbox = () => {
  const mapElement = document.getElementById('map');
    if (mapElement) {
      mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
      const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
      const markers = JSON.parse(mapElement.dataset.markers);
      addMarkersToMap(map, markers);
      const userMarkerPosition = JSON.parse(mapElement.dataset.userMarker);
      const userPosition = [userMarkerPosition.lng, userMarkerPosition.lat, userMarkerPosition.image_url];
      addUserMarkerToMap(map, userMarkerPosition);
      centerMapToUser(map, userPosition);
      map.scrollZoom.disable();
    };
};
export { initMapbox };
