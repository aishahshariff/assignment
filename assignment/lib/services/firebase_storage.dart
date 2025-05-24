import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  // Upload Image
  Future<String?> uploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    File file = File(image.path);
    Reference ref = _storage.ref().child("images/${image.name}");
    await ref.putFile(file);

    return await ref.getDownloadURL();
  }

  // Upload Video
  Future<String?> uploadVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video == null) return null;

    File file = File(video.path);
    Reference ref = _storage.ref().child("videos/${video.name}");
    await ref.putFile(file);

    return await ref.getDownloadURL();
  }

  // Download File to Device
  Future<void> downloadFile(String firebaseUrl, String fileName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/$fileName');

    try {
      await _storage.refFromURL(firebaseUrl).writeToFile(downloadToFile);
    } catch (e) {
      print("Error downloading file: $e");
    }
  }
}
