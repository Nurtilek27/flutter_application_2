import 'package:flutter/material.dart';
import 'info.dart';
import 'main5 vvod  danyx.dart';
import 'model.dart';

class NextPage4 extends StatefulWidget {
  final String storeName;
  const NextPage4(
      {Key? key, required this.storeName, required List productList})
      : super(key: key);

  @override
  _NextPage4State createState() => _NextPage4State();
}

class _NextPage4State extends State<NextPage4> {
  List<ShopModel> shopList = [];

  void _navigateToNextPage5() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NextPage5()),
    );

    if (result != null) {
      final name = result['name'];
      final date = result['date'];
      final quantity = result['quantity'];

      final productModel = ProductModel(name, date, quantity);
      productList.add(productModel);
      setState(() {});
    }
  }

  void _navigateToNextPage6(ProductModel productModel) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NextPage6(productModel)),
    );
  }

  void _removeProduct(int index) {
    setState(() {
      productList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.storeName,
          style: const TextStyle(fontSize: 24),
        ),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final productModel = productList[index];
          return Dismissible(
            key: Key(productModel.name),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) => _removeProduct(index),
            background: Container(
              color: const Color.fromARGB(255, 128, 125, 125),
              alignment: Alignment.centerLeft,
              child: const Icon(Icons.delete),
            ),
            child: ListTile(
              title: Text(
                productModel.name,
                style: const TextStyle(fontSize: 24),
              ),
              onTap: () => _navigateToNextPage6(productModel),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToNextPage5,
        child: const Icon(Icons.add),
      ),
    );
  }
}
