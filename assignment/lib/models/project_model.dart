import 'package:google_maps_flutter/google_maps_flutter.dart';

class Project {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final LatLng latlng;

  Project({required this.id, required this.name, required this.description, required this.imageUrl,
  required this.latlng});
}
// TODO Implement this library.