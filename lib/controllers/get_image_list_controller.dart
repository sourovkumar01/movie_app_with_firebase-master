import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ImageListController extends GetxController{
  List<String> movieName = [];
  List<String?> imageList = [];
  bool _getImageListInProgress=false;
  bool get isGetImageListInProgress=>_getImageListInProgress;
  Future<void> getImageList() async {
    _getImageListInProgress = true;
    update();
    final storageRef = FirebaseStorage.instance.ref().child("/Movies");
    final listResult = await storageRef.listAll();
    imageList.clear();
    movieName.clear();
    for (var item in listResult.items) {
      movieName.add(item.name);
      imageList.add(await item.getDownloadURL());
      print('--------------');
    }
    _getImageListInProgress = false;
   update();
  }
}