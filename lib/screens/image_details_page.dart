import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/image_detail_list_controller.dart';

class ImageDetailsScreen extends StatefulWidget {
  final String image;
  final String movieName;

  const ImageDetailsScreen(
      {super.key, required this.image, required this.movieName});

  @override
  State<ImageDetailsScreen> createState() => _ImageDetailsScreenState();
}

class _ImageDetailsScreenState extends State<ImageDetailsScreen> {
  bool getImageDetailsInProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        title: const Text('Movie Details'),
        centerTitle: true,
        backgroundColor: Colors.amber[800],
      ),
      body: SafeArea(
        child: imageDetailsListBuilder(context),
      ),
    );
  }

  GetBuilder<ImageDetailListController> imageDetailsListBuilder(BuildContext context) {
    return GetBuilder<ImageDetailListController>(builder: (imageController) {
        return Visibility(
            visible: imageController.getImageDetailsInProgress == false,
            replacement: const Center(child: CircularProgressIndicator()),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.network(widget.image)),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 4,
                      bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Name: ",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          Text(imageController.getImageDetail?.name ?? '',
                              style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text("Year: ",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          Text(imageController.getImageDetail?.year ?? '',
                              style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text("Language: ",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          Text(imageController.getImageDetail?.language ?? '',
                              style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ));
      });
  }

  void getImageDetails() async {
    await Get.find<ImageDetailListController>().getImageDetails(widget.movieName);
  }
}
