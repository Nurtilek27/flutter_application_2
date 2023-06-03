import 'package:flutter/material.dart';
import 'model.dart';

class NextPage6 extends StatefulWidget {
  final ProductModel productModel;

  const NextPage6(this.productModel, {Key? key}) : super(key: key);

  @override
  _NextPage6State createState() => _NextPage6State();
}

class _NextPage6State extends State<NextPage6> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.productModel.quantity;
  }

  void subtractQuantity(int value) {
    setState(() {
      if (quantity >= value) {
        quantity -= value;
      }
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int value = 0; // значение для вычитания

        return AlertDialog(
          title: const Text('Количество возвращаемых товаров'),
          content: TextFormField(
            keyboardType: TextInputType.number,
            initialValue: '',
            onChanged: (newValue) {
              value = int.tryParse(newValue) ?? 0;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите число';
              }
              if (int.tryParse(value) == null) {
                return 'Пожалуйста, введите корректное число';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: '0',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('ОК'),
              onPressed: () {
                if (value > 0) {
                  subtractQuantity(value);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
        title: Text(widget.productModel.name),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Название продукта:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              Text(
                widget.productModel.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Дата начало:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              Text(
                widget.productModel.date,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Количество:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              Text(
                quantity >= 0 ? quantity.toString() : quantity.abs().toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: const Icon(Icons.remove),
      ),
    );
  }
}
