import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/main3.dart';
import 'package:flutter_application_2/main4.dart';
import 'package:flutter_application_2/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  late SharedPreferences _prefs;
  List<dynamic> shopList = [];

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    getDataFromSharedPreferences();
  }

  void getDataFromSharedPreferences() {
    final savedShopList = _prefs.getStringList('shopList');
    if (savedShopList != null) {
      setState(() {
        shopList = savedShopList
            .map((json) => ShopModel.fromJson(json))
            .toList();
      });
    }
  }

  void saveDataToSharedPreferences() {
     final jsonList = shopList.map((shop) => jsonEncode(shop.toJson())).toList();
    _prefs.setStringList('shopList', jsonList);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Магазины2'),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) => Stack(
              children: [
                Dismissible(
                  key: Key(shopList[index].name),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    setState(() {
                    saveDataToSharedPreferences(); // Сохраняем изменения до удаления магазина
                      shopList.removeAt(index); 
                    });
                  },
                  background: Container(
                    color: const Color.fromARGB(255, 128, 125, 125),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(right: 50),
                    child: const Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 30, 30, 30),
                      size: 32,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NextPage4(
                            storeName: shopList[index].name,
                            productList: const [],
                            prefs: _prefs,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            shopList[index].name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            shopList[index].address,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                thickness: 3,
                color: Colors.grey,
              ),
            ),
            itemCount: shopList.length,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NextPage1(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}