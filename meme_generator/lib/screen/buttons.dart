import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/domain/models/image_model.dart';
import 'package:meme_generator/screen/card_container.dart';
import 'package:meme_generator/screen/utils.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'image_url.dart';

class Buttons extends StatefulWidget {
  const Buttons({Key? key, required this.memeName}) : super(key: key);
  final String memeName;
  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  final _formKey = GlobalKey<FormState>();
  Uint8List? bytes;
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
            width: responsiveSize * 0.4,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple),
                child: ElevatedButton(
                  onPressed: (() async {
                    final controller = ScreenshotController();
                    final bytes = await controller.captureFromWidget(
                        CardContainer(
                            placeholder: placeholder,
                            memeName: widget.memeName));
                    setState(() {
                      this.bytes = bytes;
                    });
                    shareImage();
                  }),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.ios_share_rounded,
                      color: Colors.white,
                    ),
                  ),
                )),
          )
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

  shareImage() async {
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.png';
    File(path).writeAsBytesSync(bytes!);
    await Share.shareXFiles([XFile(path)]);
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
          PopupMenuItem(
            value: 2,
            onTap: () {
              _pickImageFromUrl();
            },
            child: const Text(
              "Вставить из URL",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
        ],
        child: SizedBox(
          height: 40,
          width: responsiveSize * 0.4,
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
                Icons.photo_camera,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
  void _pickImageFromUrl() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      context: context,
      isScrollControlled: true,
      builder: (context) => PickImageFromUrl(formKey: _formKey),
    );
  }
}
