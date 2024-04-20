import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class UploadDataController extends GetxController{
  bool _uploadTextDataInProgress=false;
  bool _uploadImageInProgress=false;
  bool get isUploadTextDataInProgress =>_uploadTextDataInProgress;
  bool get isUploadImageInProgress =>_uploadImageInProgress;
  void uploadTextData(Map<String,String> inputParams) {
    _uploadTextDataInProgress = true;
   update();
    final db = FirebaseFirestore.instance;

    if (inputParams['name']?.isNotEmpty??false) {
      db
          .collection('MovieDetails')
          .doc(inputParams['name'])
          .set(inputParams);
    }
    _uploadTextDataInProgress = false;
    update();
  }


  Future<bool> uploadImage(File? file,String movieName,FilePickerResult? fileResult) async {
    _uploadImageInProgress = true;
    update();
    if (file != null) {
      try {
        await FirebaseStorage.instance
            .ref()
            .child('/Movies')
            .child(movieName.isNotEmpty
            ? movieName
            : fileResult?.names[0] ?? 'unknown')
            .putFile(file);
        _uploadImageInProgress = false;
        update();
           return true;
      } catch (e) {
        log(e.toString());
      }
    }
    _uploadImageInProgress = false;
    update();
    return false;
  }

}