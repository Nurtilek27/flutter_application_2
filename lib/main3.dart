import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/model.dart';
import 'main2.dart';

class NextPage1 extends StatefulWidget {
  const NextPage1({Key? key}) : super(key: key);

  @override
  _NextPage1State createState() => _NextPage1State();
}

class _NextPage1State extends State<NextPage1> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addresController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(' '),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Название магазина'),
              // ignore: body_might_complete_normally_nullable
              validator: (String? double) {
                if (double!.isEmpty) {
                  return 'Поле не может быть пустым';
                }
              },
            ),
            TextFormField(
              controller: addresController,
              decoration: const InputDecoration(labelText: 'Адресс магазина'),
              // ignore: body_might_complete_normally_nullable
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Поле не может быть пустым';
                }
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NextPage(),
                    ),
                  );
                  shopList.add(
                    ShopModel(
                      nameController.text,
                      addresController.text,
  
                    ),
                  );
                }
              },
              child: const Text('Готово'),
            )
          ]),
        ),
      ),
    ));
  }
}
