import 'dart:io';
import 'package:flutter/material.dart';

class ImageProviderModel with ChangeNotifier {
  File? _image;
  String? _imageFromUrl;

  File? get image => _image;
  String? get imageUrl => _imageFromUrl;

  void setImage(File? newImage) {
    _image = newImage;
    _imageFromUrl = null; // Очищаем URL изображения
    notifyListeners();
  }

  void setImageUrl(String? url) {
    _imageFromUrl = url;
    _image = null; // Очищаем файл изображения
    notifyListeners();
  }
}
