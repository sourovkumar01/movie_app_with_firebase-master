import 'package:firebase_practice2/controllers/get_image_list_controller.dart';
import 'package:firebase_practice2/controllers/image_detail_list_controller.dart';
import 'package:firebase_practice2/controllers/upload_data_controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => ImageListController(),fenix:true);
    Get.lazyPut(() => ImageDetailListController(),fenix:true);
    Get.lazyPut(() => UploadDataController(),fenix:true);
  }

}