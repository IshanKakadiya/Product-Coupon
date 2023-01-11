// import 'package:flutter/cupertino.dart';
// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import '../model/product.dart';
import '../res/globle.dart';

class CartProvider extends ChangeNotifier {
  get allProduct {
    int totalcount = 0;
    Globle.cartData.forEach((element) {
      totalcount += element.count;
    });
    return totalcount;
  }

  get totalPrice {
    num price = 0;
    for (int i = 0; i < Globle.cartData.length; i++) {
      price += (Globle.cartData[i].price * Globle.cartData[i].count);
    }
    return price;
  }

  void Countpluse({required Product product}) {
    product.count++;
    notifyListeners();
  }

  void CountdecrementAndRemove({required Product product}) {
    if (product.count > 1) {
      product.count--;

      notifyListeners();
    }
  }

  void RemoveFromCart({required Product product}) {
    product.count = 0;

    Globle.cartData.remove(product);

    notifyListeners();
  }

  void addToCart({required Product product}) {
    if (product.count >= 1) {
    } else {
      product.count++;
      Globle.cartData.add(product);

      notifyListeners();
    }
  }
}
