import 'package:final_project/model/coupon.dart';

import '../model/product.dart';

class Globle {
  static bool data = false;
  static int addProductId = 1;
  static List<Product> cartData = [];
  static List<Coupon> couponCode = [];

  // Coupon
  static List promocode = [
    Coupon(code: "Ishan", stock: 30),
    Coupon(code: "Ishan003", stock: 3),
    Coupon(code: "Ishan24", stock: 5),
  ];

  // Product
  static List<Map<dynamic, dynamic>> fruits = [
    {'id': 1, 'name': 'Vegetables', 'image': 'assets/vegetable.png'},
    {'id': 2, 'name': 'Fruit', 'image': 'assets/fruit.png'},
    {'id': 3, 'name': 'Mushroom', 'image': 'assets/mushroom.png'},
    {'id': 4, 'name': 'Peas', 'image': 'assets/peas.png'},
    {'id': 5, 'name': 'Dairy', 'image': 'assets/dairy-products.png'},
  ];

  static List<Product> products = [
    // 1
    Product(
      id: 1,
      image: 'assets/cabbage.png',
      productName: "Cabbage",
      price: 149,
      stock: 30,
    ),
    Product(
      id: 1,
      image: 'assets/carrot.png',
      productName: "Carrot",
      price: 19,
      stock: 20,
    ),
    Product(
      id: 1,
      image: 'assets/eggplant.png',
      productName: "Eggplant",
      price: 39,
      stock: 19,
    ),
    Product(
      id: 1,
      image: 'assets/tomato.png',
      productName: "Tomato",
      price: 40,
      stock: 26,
    ),

    // 2
    Product(
      id: 2,
      image: 'assets/apple.png',
      productName: "Apple",
      price: 36,
      stock: 78,
    ),
    Product(
      id: 2,
      image: 'assets/kiwi.png',
      productName: "Kiwi",
      price: 47,
      stock: 78,
    ),
    Product(
      id: 2,
      image: 'assets/strawberry.png',
      productName: "Strawberry",
      price: 67,
      stock: 45,
    ),
    Product(
      id: 2,
      image: 'assets/banana.png',
      productName: "Banana",
      price: 25,
      stock: 29,
    ),

    // 3
    Product(
      id: 3,
      image: 'assets/mushroom (4).png',
      productName: "Mushroom",
      price: 79,
      stock: 112,
    ),
    Product(
      id: 3,
      image: 'assets/mushroom (1).png',
      productName: "fungi",
      price: 99,
      stock: 110,
    ),
    Product(
      id: 3,
      image: 'assets/mushroom (2).png',
      productName: "Mushroom",
      price: 199,
      stock: 87,
    ),
    Product(
      id: 3,
      image: 'assets/mushroom (3).png',
      productName: "Mushroom",
      price: 149,
      stock: 29,
    ),

    // 4
    Product(
      id: 4,
      image: 'assets/peas (2).png',
      productName: "Peas",
      price: 45,
      stock: 112,
    ),
    Product(
      id: 4,
      image: 'assets/pea (1).png',
      productName: "Pea",
      price: 99,
      stock: 110,
    ),
    Product(
      id: 4,
      image: 'assets/green-pea.png',
      productName: "GreenPea",
      price: 199,
      stock: 87,
    ),
    Product(
      id: 4,
      image: 'assets/pea.png',
      productName: "Peas",
      price: 149,
      stock: 29,
    ),

    // 5
    Product(
      id: 5,
      image: 'assets/milk.png',
      productName: "Milk",
      price: 29,
      stock: 112,
    ),
    Product(
      id: 5,
      image: 'assets/dairy-products (1).png',
      productName: "DairyProducts",
      price: 99,
      stock: 110,
    ),
    Product(
      id: 5,
      image: 'assets/butter.png',
      productName: "Butter",
      price: 199,
      stock: 87,
    ),
    Product(
      id: 5,
      image: 'assets/cow.png',
      productName: "Cow",
      price: 2349,
      stock: 29,
    ),
  ];
}
