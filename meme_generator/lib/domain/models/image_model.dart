import 'dart:io';
import 'package:flutter/material.dart';

class ImageProviderModel with ChangeNotifier {
  File? _image;

  File? get image => _image;

  void setImage(File newImage) {
    _image = newImage;
    notifyListeners();
  }
}
