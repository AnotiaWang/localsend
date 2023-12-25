import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageProvider extends ChangeNotifier {
  List<Image> _images = [];

  List<Image> get images => List.from(_images);

  void storeImages(List<Image> newImages) {
    _images.clear();
    _images.addAll(newImages);
    notifyListeners();
  }

  Image? getImage(int index) {
    if (index >= 0 && index < _images.length) {
      return _images[index];
    }
    return null;
  }
}
