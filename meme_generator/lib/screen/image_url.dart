import 'package:flutter/material.dart';
import 'package:meme_generator/domain/models/image_model.dart';
import 'package:meme_generator/screen/utils.dart';
import 'package:provider/provider.dart';

class PickImageFromUrl extends StatelessWidget {
  PickImageFromUrl({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProviderModel>(context);
    return Padding(
      padding: EdgeInsets.only(
          right: 10,
          left: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: responsiveSize * 0.55,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text("Вставьте URL адрес изображения и мы сотворим мем"),
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
                    if (!_isValidImageUrl(value)) {
                      return 'Введите корректный URL изображения';
                    }
                    return null;
                  },
                  controller: _urlController,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.link, color: Colors.deepPurple),
                    border: InputBorder.none,
                    counterText: "",
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    hintText: "Формат: jpg, png, jpeg",
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
                          if (_isValidImageUrl(_urlController.text)) {
                            imageProvider.setImageUrl(_urlController.text);
                          }
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Открыть",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isValidImageUrl(String? url) {
    if (url == null) {
      return false;
    }
    // Простейшая проверка формата URL и расширения файла
    final uri = Uri.tryParse(url);
    if (uri != null && (uri.isScheme('http') || uri.isScheme('https'))) {
      final lowerCaseUrl = url.toLowerCase();
      return lowerCaseUrl.endsWith('.png') ||
          lowerCaseUrl.endsWith('.jpg') ||
          lowerCaseUrl.endsWith('.jpeg');
    }
    return false;
  }
}
