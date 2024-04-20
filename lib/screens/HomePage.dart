import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_practice2/controllers/image_detail_list_controller.dart';
import 'package:firebase_practice2/controllers/get_image_list_controller.dart';
import 'package:firebase_practice2/screens/image_details_page.dart';
import 'package:firebase_practice2/screens/movie_upload_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> movieName = [];
  List<String?> imageList = [];
  FilePickerResult? fileResult;
  File? file;

  @override
  void initState() {
    super.initState();
    getImageList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Gallery'),
          backgroundColor: Colors.amber[800]),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber[800],
          onPressed: () {
            Get.to(const MovieUploadScreen());
          },
          child: const Icon(Icons.add)),
      body: RefreshIndicator(
        onRefresh: () {
          return getImageList();
        },
        child: GetBuilder<ImageListController>(
          builder: (imageListController) {
            return Visibility(
              visible: imageListController.isGetImageListInProgress == false,
              replacement: const Center(child: CircularProgressIndicator()),
              child: imageGridViewBuilder(),
            );
          }
        ),
      ),
    );
  }

  GridView imageGridViewBuilder() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.72),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageDetailsScreen(
                            image: imageList[index]!,
                            movieName: movieName[index] ?? '',
                          )));
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              child: Image.network(imageList[index]!, fit: BoxFit.fill),
            ),
          );
        },
        //shrinkWrap: true,
        itemCount: imageList.length);
  }
  Future<void> getImageList() async {
    await Get.find<ImageListController>().getImageList();
    imageList =  Get.find<ImageListController>().imageList;
    movieName = Get.find<ImageListController>().movieName;
  }


}
