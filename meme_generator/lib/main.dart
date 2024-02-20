import 'package:flutter/material.dart';
import 'package:meme_generator/screen/meme_generator_screen.dart';
import 'package:provider/provider.dart';

import 'domain/models/image_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (context) => ImageProviderModel(),
    child: const MyApp(),
  ));
}

/// App,s main widget.
class MyApp extends StatelessWidget {
  /// Constructor for [MyApp].
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Покинуть приложение'),
              content: const Text('Хотите выйти?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Нет'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Да'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MemeGeneratorScreen(),
    );
  }
}
