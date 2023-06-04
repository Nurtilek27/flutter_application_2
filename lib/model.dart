class ShopModel {
  final String name;
  final String address;

  ShopModel(
    this.name,
    this.address,
  );
  
 
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
