import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localsend_app/model/device.dart';
import 'package:localsend_app/provider/network/send_provider.dart';

class ViewMobilePicturesProvider extends ChangeNotifier {
  List<ImageProvider> _pictures = [];

  List<ImageProvider> get pictures => _pictures;

  Future<void> fetchPictures(Device device) async {
    // Use the SendNotifier to send a request to the device to fetch the pictures
    // For simplicity, we assume that the SendNotifier has a method getDevicePictures that takes a Device object and returns a List<ImageProvider>
    _pictures = await SendNotifier().getDevicePictures(device);

    // Notify listeners of the state change
    notifyListeners();
  }

  void clearPictures() {
    _pictures.clear();

    // Notify listeners of the state change
    notifyListeners();
  }
}
