import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/domain/models/image_model.dart';
import 'package:provider/provider.dart';

class Buttons extends StatefulWidget {
  const Buttons({Key? key}) : super(key: key);

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  final placeholder =
      'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg';

  final _formKey = GlobalKey<FormState>();
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
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.55,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child:
                      Text("Вставьте URL адрес изображения и мы сотворим мем"),
                ),
                Stack(children: [
                  Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      )),
                  TextFormField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Пустое поле";
                      }
                      return null;
                    },
                    obscureText: false,
                    //controller:
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.link, color: Colors.black),
                      border: InputBorder.none,
                      counterText: "",
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      labelText: "Вставьте ссылку",
                      labelStyle: TextStyle(color: Colors.grey),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 164, 167, 169),
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            alignment: Alignment.center,
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepPurple),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            )),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text(
                          "Отправить",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
