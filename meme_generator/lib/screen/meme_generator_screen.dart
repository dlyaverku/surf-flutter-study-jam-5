import 'package:flutter/material.dart';
import 'package:meme_generator/domain/models/image_model.dart';
import 'package:meme_generator/screen/buttons.dart';
import 'package:provider/provider.dart';

class MemeGeneratorScreen extends StatefulWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<MemeGeneratorScreen> createState() => _MemeGeneratorScreenState();
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen> {
  final _textController = TextEditingController();
  final placeholder =
      'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg';

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ColoredBox(
            color: Colors.black,
            child: DecoratedBox(
              decoration: decoration,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: DecoratedBox(
                        decoration: decoration,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Consumer<ImageProviderModel>(
                            builder: (context, imageProvider, child) {
                              return imageProvider.image != null
                                  ? Image.file(imageProvider.image!)
                                  : Image.network(placeholder);
                            },
                          ),
                        ),
                      ),
                    ),
                    Text(
                      _textController.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Impact',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
            child: TextFormField(
              controller: _textController,
              onChanged: (value) {
                setState(() {
                  _textController.text = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Название мема',
                hintText: 'Напишите название мема',
              ),
            ),
          ),
          const Buttons()
        ]));
  }
}
