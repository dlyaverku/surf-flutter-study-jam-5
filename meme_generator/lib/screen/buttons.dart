import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/domain/models/image_model.dart';
import 'package:provider/provider.dart';

typedef ImageSelectCallback = void Function(File imageFile);

class Buttons extends StatefulWidget {
  const Buttons({Key? key}) : super(key: key);

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  final placeholder =
      'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _childPopup(),
          SizedBox(
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                ),
                child: const Text(
                  "Сгенерировать запрос",
                  style: TextStyle(
                    fontFamily: 'Impact',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _pickImageFromGallery(context) async {
    final imageProvider =
        Provider.of<ImageProviderModel>(context, listen: false);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageProvider.setImage(File(pickedFile.path));
    }
  }

  Widget _childPopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            onTap: () async {
              _pickImageFromGallery(context);
            },
            child: const Text(
              "Выбрать из галереи",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
          const PopupMenuItem(
            value: 2,
            child: Text(
              "Вставить из URL",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
        ],
        child: SizedBox(
          height: 40,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple),
            child: ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
              ),
              child: const Icon(
                Icons.image_search_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
}
