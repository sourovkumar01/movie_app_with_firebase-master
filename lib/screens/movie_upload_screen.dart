import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_practice2/controllers/upload_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieUploadScreen extends StatefulWidget {
  const MovieUploadScreen({super.key});

  @override
  State<MovieUploadScreen> createState() => _MovieUploadScreenState();
}

class _MovieUploadScreenState extends State<MovieUploadScreen> {
  FilePickerResult? fileResult;
  File? file;
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _yearTEController = TextEditingController();
  final TextEditingController _languageTEController = TextEditingController();
  bool uploadTextDataInProgress = false;
  bool uploadImageInProgress = false;
  bool canGoBack = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Upload Movies'),
          backgroundColor: Colors.amber[800]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: uploadWidgetBuilder(context),
      ),
    );
  }

  GetBuilder<UploadDataController> uploadWidgetBuilder(BuildContext context) {
    return GetBuilder<UploadDataController>(
        builder: (uploadDataController) {
          return Column(children: [
            GestureDetector(
              onTap: () {
                pickImage();
              },
              child: uploadImageBox(),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(hintText: 'Enter Movie Name'),
              controller: _nameTEController,
            ),
            const SizedBox(height: 10),
            TextField(
                decoration: const InputDecoration(hintText: 'Enter Release Year'),
                controller: _yearTEController),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(hintText: 'Enter Languages'),
              controller: _languageTEController,
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: uploadDataController.isUploadImageInProgress == false &&
                  uploadDataController.isUploadTextDataInProgress == false,
              replacement: const CircularProgressIndicator(),
              child: uploadTextButton(context),
            ),
          ]);
        }
      );
  }

  TextButton uploadTextButton(BuildContext context) {
    return TextButton(
                onPressed: () {
                  uploadImage();
                  uploadTextData();
                  if (canGoBack) {
                    Navigator.pop(context);
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.amber[800],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: const Text('Upload'));
  }

  Container uploadImageBox() {
    return Container(
              //alignment: Alignment.center,
              height: 125,
              width: 110,
              decoration:
              BoxDecoration(border: Border.all(color: Colors.amber)),
              margin: const EdgeInsets.all(8),
              child: file != null
                  ? Image.file(file!, fit: BoxFit.fill)
                  : const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 37, top: 5),
                      child: Text(
                        "Upload Image Here",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Text(
                    '+',
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
            );
  }

  void uploadTextData() {
    Map<String, String> inputParams = {
      'name': _nameTEController.text.trim(),
      'year': _yearTEController.text.trim(),
      'language': _languageTEController.text.trim(),
    };
    Get.find<UploadDataController>().uploadTextData(inputParams);
  }

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      fileResult = result;
      file = File(result.files.single.path!);
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  Future<void> uploadImage() async {
    bool isSuccess = await Get.find<UploadDataController>().uploadImage(
        file, _nameTEController.text.trim(), fileResult);
    if (isSuccess) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Success'),
            backgroundColor: Colors.amber,
          ));
          _nameTEController.clear();
          _languageTEController.clear();
          _yearTEController.clear();
          file = null;
          canGoBack = true;
          Get.find<UploadDataController>().update();
        }
      }
    }


  Future uploadDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Are You Want To Upload ?'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: SizedBox(
                    height: 65,
                    width: 60,
                    child: Image.file(file!),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    uploadImage();
                    Navigator.pop(context);
                  },
                  child: const Text('Yes'))
            ],
          );
        });
  }
}
