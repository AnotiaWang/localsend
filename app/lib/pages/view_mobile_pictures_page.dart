import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:localsend_app/util/native/open_gallery_image.dart';

class ViewMobilePicturesPage extends StatefulWidget {
  @override
  _ViewMobilePicturesPageState createState() => _ViewMobilePicturesPageState();
}

class _ViewMobilePicturesPageState extends State<ViewMobilePicturesPage> {
  List<AssetEntity> images = [];

  @override
  void initState() {
    super.initState();
    getImages();
  }

  Future<void> getImages() async {
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;
    final recentImages = await recentAlbum.getAssetListRange(start: 0, end: 10000);

    setState(() {
      images = recentImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Mobile Pictures'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => openFolder(images[index].relativePath),
            child: Image.memory(
              images[index].thumbData.buffer.asUint8List(),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
