// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NextPage5 extends StatefulWidget {
  const NextPage5({Key? key}) : super(key: key);

  @override
  _NextPage5State createState() => _NextPage5State();
}

class _NextPage5State extends State<NextPage5> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('NextPage5'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration:
                    const InputDecoration(labelText: 'Название продукта'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Поле не может быть пустым';
                  }
                  return null;
                },
              ),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  ).then((date) {
                    if (date != null) {
                      setState(() {
                        selectedDate = date;
                        dateController.text = date.toString().split(' ')[0];
                      });
                    }
                  });
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(labelText: 'Дата начало'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Поле не может быть пустым';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              TextFormField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Количество'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Поле не может быть пустым';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (selectedDate != null) {
                      final result = {
                        'name': nameController.text,
                        'date': dateController.text,
                        'quantity': int.parse(quantityController.text),
                      };

                      Navigator.pop(context, result);
                    }
                  }
                },
                child: const Text(
                  'Готово',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
