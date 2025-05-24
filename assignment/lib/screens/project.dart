import 'package:assignment/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../services/project_service.dart';
import '../screens/project_details_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import 'chartd.dart';
import 'map.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  FirebaseStorage storage = FirebaseStorage.instance;
  final User? user = AuthService().currentUser;
  List<Project> displayedProjects = projectList;
  TextEditingController searchController = TextEditingController();
  File? _imageFile;

  void searchProjects(String query) {
    final filteredProjects = projectList.where((project) =>
        project.name.toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {
      displayedProjects = filteredProjects;
    });
  }
  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);
      try {
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'A bad guy',
              'description': 'Some description...'
            }));

        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  // Retriew the uploaded images
  // This function is called when the app launches for the first time or when an image is uploaded or deleted
  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
          "url": fileUrl,
          "path": file.fullPath,
          "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
          "description":fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    return files;
  }

  // Delete the selected image
  // This function is called when a trash icon is pressed
  Future<void> _delete(String ref) async {
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState(() {});
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Projects"),
        backgroundColor: Colors.purple,
        actions: [
          MaterialButton(
              onPressed: () async {
                await AuthService().signOut();
              },
              child: Text('Signout', style: TextStyle(color: Colors.black)))
        ],),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Search Projects",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: searchProjects,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedProjects.length,
              itemBuilder: (context, index) {
                final project = displayedProjects[index];
                return ListTile(
                  leading: Image.network(project.imageUrl),
                  title: Text(project.name),
                  subtitle: Text(project.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectDetailsScreen(project: project),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>/*[
              _imageFile != null
                  ? Image.file(_imageFile!)
                  : Text('No image selected.'),
              Padding(
                padding: EdgeInsets.only(top: 31, bottom: 21),
                child: MaterialButton(
                  onPressed: () async {
                    final imageFile = await pickImage();
                    if (imageFile != null) {
                      setState(() {
                        _imageFile = imageFile;
                      });
                      await uploadImage(imageFile);
                    }
                  },
                  padding: EdgeInsets.symmetric(vertical: 13),
                  minWidth: double.infinity,
                  color: Colors.purple.shade300,
                  disabledColor: Colors.grey.shade300,
                  textColor: Colors.white,
                  child: Text('Upload Image/Video'),
                ),
              ),
            ]*/[
                ElevatedButton.icon(
                onPressed: () => _upload('gallery'),
                icon: const Icon(Icons.library_add),
                label: const Text('Gallery')),
              ElevatedButton.icon(
                  onPressed: () =>Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.map),
                  label: const Text('Map')),
              ElevatedButton.icon(
                  onPressed: () =>Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChartScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.show_chart),
                  label: const Text('Chart'))
                /*Expanded(
                child: FutureBuilder(
                future: _loadImages(),
                builder: (context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                final Map<String, dynamic> image =
                snapshot.data![index];

                return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                dense: false,
                leading: Image.network(image['url']),
                title: Text(image['uploaded_by']),
                subtitle: Text(image['description']),
                trailing: IconButton(
                onPressed: () => _delete(image['path']),
                icon: const Icon(
                Icons.delete,
                color: Colors.red,
                ),
                ),
                ),
                );
                },
                );
                }

                return const Center(
                child: CircularProgressIndicator(),
                );
                } ),
                    )*/
                  ],
                )]));
  }
}
