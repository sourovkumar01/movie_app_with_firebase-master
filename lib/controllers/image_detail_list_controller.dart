import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice2/models/imageDetailsModel.dart';
import 'package:get/get.dart';

class ImageDetailListController extends GetxController{
  bool getImageDetailsInProgress=false;
  final  db = FirebaseFirestore.instance;
  ImageDetails? imageDetails;
 Map<String,dynamic> m={};
  bool get isGetImageDetailsInProgress =>getImageDetailsInProgress;
  ImageDetails? get getImageDetail=>imageDetails;
  Future<void> getImageDetails(String movieName)async{
    getImageDetailsInProgress = true;
    update();
    //print(widget.movieName);
    final docRef = db.collection("MovieDetails").doc(movieName);
    docRef.get().then(
          (DocumentSnapshot doc) {
        print(doc.data());
        final movies = doc.data() as Map<String, dynamic>;
        imageDetails = ImageDetails.fromJson(movies);
        update();
      },
      onError: (e) => print("Error getting document: $e"),
    );
    getImageDetailsInProgress = false;
    update();
  }


}