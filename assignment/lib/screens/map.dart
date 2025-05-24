import 'package:assignment/screens/project_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/project_model.dart';
import '../services/project_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
 // List<Project> displayedProjects = projectList;

  // Sample project locations
  final List<LatLng> projectLocations =
  [
    LatLng(13.011053, 77.554939), // Bengaluru
    LatLng(12.991753, 77.569641), // Delhi
    LatLng(12.995854, 77.696350), // Mumbai
  ];

  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() {
    setState(() {
      _markers.clear();
      for (int i = 0; i < projectList.length; i++) {
        final project = projectList[i];
        final marker = Marker(
          markerId: MarkerId(projectList[i].name),
          position: projectList[i].latlng,
          infoWindow: InfoWindow(
            title: projectList[i].name,
            snippet: 'Location: ${projectList[i].latlng.latitude}, ${projectList[i].latlng.longitude}',
          ),
          onTap:(){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjectDetailsScreen(project: project),
              ),
            );
          }
        );
        _markers['Project $i'] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title: Text("Map"),
    backgroundColor: Colors.purple,),
    body: GoogleMap(
      onMapCreated: (controller) => mapController = controller,
      initialCameraPosition: CameraPosition(
        target: projectList[1].latlng, // Focus on the first location
        zoom: 10,
      ),
      markers: _markers.values.toSet(),
    ),

    );
  }
  
}