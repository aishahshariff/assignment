import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/project_model.dart';

final List<Project> projectList = [
  Project(id: '1', name: 'Project Alpha', description: 'Description of Alpha',
      imageUrl: 'https://cdn.corporatefinanceinstitute.com/assets/alpha-1024x865.jpeg',
  latlng: LatLng(13.011053, 77.554939)),
  Project(id: '2', name: 'Project Beta', description: 'Description of Beta',
      imageUrl: 'https://t3.ftcdn.net/jpg/02/97/09/28/360_F_297092884_gLlDFgn4oO8XxwBGCGT6A7gHXnqj15EY.jpg',
  latlng: LatLng(12.991753, 77.569641)),
  Project(id: '3', name: 'Project Gamma', description: 'Description of Gamma',
      imageUrl: 'https://cdn.mos.cms.futurecdn.net/cfo9wrPuw9H2NXugivFUJh-1920-80.jpg',
  latlng: LatLng(12.995854, 77.696350)),
];
// TODO Implement this library.