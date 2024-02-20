import 'package:flutter/material.dart';
import 'package:meme_generator/screen/buttons.dart';
import 'package:meme_generator/screen/card_container.dart';
import 'package:meme_generator/screen/utils.dart';

class MemeGeneratorScreen extends StatefulWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<MemeGeneratorScreen> createState() => _MemeGeneratorScreenState();
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ColoredBox(
              color: Colors.black,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  child: CardContainer(
                      placeholder: placeholder, memeName: _textController.text),
                ),
              )),
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
          Buttons(
            memeName: _textController.text,
          )
        ]));
  }
}
