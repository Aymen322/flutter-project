import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCardWidget extends StatelessWidget {
  final String title;
  final String education;
  final Color colorIcon;
  final LatLng coordinates;

  const MapCardWidget({
    required this.title,
    required this.education,
    required this.colorIcon,
    required this.coordinates,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(title),
            subtitle: Text(education),
          ),
          SizedBox(
            height: 200,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: coordinates,
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: MarkerId(title),
                  position: coordinates,
                  infoWindow: InfoWindow(title: title, snippet: education),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
