import 'package:flutter/material.dart';
import 'package:meme_generator/domain/models/image_model.dart';
import 'package:provider/provider.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.placeholder,
    required this.memeName,
  });

  final String placeholder;
  final String memeName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: 200,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Consumer<ImageProviderModel>(
                builder: (context, imageProvider, child) {
                  // ignore: unnecessary_null_comparison
                  if (imageProvider.imageUrl != null) {
                    return Image.network(imageProvider.imageUrl!);
                  }
                  if (imageProvider.image != null) {
                    return Image.file(imageProvider.image!);
                  } else {
                    return Image.network(placeholder);
                  }
                },
              ),
            ),
          ),
        ),
        Text(
          memeName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Impact',
            fontSize: 40,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
