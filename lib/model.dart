

class ShopModel {
  String name;
  String address;

  ShopModel({required this.name, required this.address});

  static fromJson(String json) {}

  toJson() {}
}

class ProductModel {
  final String name;
  final String date;
  final int quantity;

  ProductModel(
    this.name,
    this.date,
    this.quantity,
  );

  static fromJson(data) {}

  toJson() {}
}

List<ProductModel> productList = [];

List<ShopModel> shopList = [];
