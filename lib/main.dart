import 'package:flutter/material.dart';
import 'main2.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinCodeController = TextEditingController();

  @override
  void dispose() {
    _pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(60.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _pinCodeController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: 'Фамилия Имя'),

              // ignore: body_might_complete_normally_nullable
              validator: (value) {
                if (value!.isEmpty) return 'Поле не может быть пустым';
                if (value != 'Исамидинов Нуртилек') {
                  return 'Такого пользователя не существует';
                }
                // Добавьте дополнительную логику проверки для PIN-кода здесь
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final String pinCode = _pinCodeController.text;
                  if (pinCode == 'Исамидинов Нуртилек') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const NextPage()));
                  } else {}
                }
              },
              child: const Text(
                'Войти',
                style: TextStyle(color: Color.fromARGB(255, 249, 249, 249)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
          body: const MyForm(),
        ),
      ),
    );
