import 'package:flutter/material.dart';
import '../models/project_model.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final Project project;

  ProjectDetailsScreen({required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(project.name),
          backgroundColor: Colors.purple),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(project.imageUrl),
            SizedBox(height: 20),
            Text(project.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Padding(
            padding: EdgeInsets.only(top: 31, bottom: 21),
            child: MaterialButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ImagesSection(project: project))
                ),
                padding: EdgeInsets.symmetric(vertical: 13),
                minWidth: double.infinity,
                color: Colors.purple.shade300,
                disabledColor: Colors.grey.shade300,
                textColor: Colors.white,
                child:Text("Images Section")),
            ),
            Padding(
              padding: EdgeInsets.only(top: 31, bottom: 21),
              child: MaterialButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => VideosSection(project: project))
                ),
                padding: EdgeInsets.symmetric(vertical: 13),
                minWidth: double.infinity,
                color: Colors.purple.shade300,
                disabledColor: Colors.grey.shade300,
                textColor: Colors.white,
                child: Text("Videos Section"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagesSection extends StatelessWidget {
  final Project project;

  ImagesSection({required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Images - ${project.name}")),
      body: Center(child: Text("Display project images here")),
    );
  }
}

class VideosSection extends StatelessWidget {
  final Project project;

  VideosSection({required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Videos - ${project.name}")),
      body: Center(child: Text("Display project videos here")),
    );
  }
}

// TODO Implement this library.