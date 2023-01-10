class Product {
  final int id;
  final String image;
  final String productName;
  final int price;
  final int stock;
  String isAdd;
  int count;

  Product({
    required this.id,
    required this.image,
    required this.productName,
    required this.price,
    required this.stock,
    this.isAdd = "false",
    this.count = 1,
  });

  factory Product.fromMap({required Map<String, dynamic> data}) {
    return Product(
      id: data["id"],
      image: data["image"],
      productName: data["productName"],
      price: data["price"],
      stock: data["stock"],
    );
  }
}
