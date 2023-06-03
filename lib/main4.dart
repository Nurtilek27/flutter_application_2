import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'info.dart';
import 'main5 vvod  danyx.dart';
import 'model.dart';
class NextPage4 extends StatefulWidget {
  final String storeName;
  final List<ProductModel> productList;
  final SharedPreferences prefs;

  const NextPage4({
    Key? key,
    required this.storeName,
    required this.productList,
    required this.prefs,
  }) : super(key: key);

  @override
  _NextPage4State createState() => _NextPage4State();
}

class _NextPage4State extends State<NextPage4> {
  List<dynamic> productList = [];

  @override
  void initState() {
    super.initState();
    getDataFromSharedPreferences();
  }

  void getDataFromSharedPreferences() {
    final savedProductList = widget.prefs.getStringList('productList_${widget.storeName}');
    if (savedProductList != null) {
      setState(() {
        productList = savedProductList
            .map((json) => ProductModel.fromJson(json))
            .toList();
      });
    }
  }

  void saveDataToSharedPreferences() {
    final jsonList = productList.map((product) =>JsonEncoder(product.toJson())).toList();
    widget.prefs.setStringList('productList_${widget.storeName}', jsonList.cast<String>());
  }

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
      setState(() {
        saveDataToSharedPreferences(); // Сохраняем новый продукт в SharedPreferences
      });
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
      saveDataToSharedPreferences(); // Сохраняем изменения после удаления продукта
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