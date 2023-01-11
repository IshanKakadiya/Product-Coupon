// ignore_for_file: camel_case_types, prefer_final_fields, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:final_project/Provider/cart_Provider.dart';
import 'package:final_project/view/screen/Home_Page.dart';
import "package:flutter/material.dart";
import '../../helper/product_helper.dart';
import '../../model/product.dart';
import '../../res/globle.dart';

class Cart_Page extends StatefulWidget {
  const Cart_Page({super.key});

  @override
  State<Cart_Page> createState() => _Cart_PageState();
}

class _Cart_PageState extends State<Cart_Page> {
  @override
  void initState() {
    super.initState();
    getAllData = Product_Helper.product_helper.fetchRecord();
  }

  get totalPrice {
    num price = 0;
    for (int i = 0; i < Globle.cartData.length; i++) {
      price += (Globle.cartData[i].price * Globle.cartData[i].count);
    }

    for (var code in Globle.promocode) {
      if (code["apply"] == true) {
        price = price - (price * 10) / 100;
      }
    }
    return price;
  }

  GlobalKey<FormState> promocodeKey = GlobalKey<FormState>();
  TextEditingController promocodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    //
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Cart Page"),
        centerTitle: true,
        backgroundColor: const Color(0xffBAB63B),
        actions: [
          IconButton(
            icon: const Icon(Icons.code),
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Center(
                        child: Text("Enter Promocode"),
                      ),
                      content: Form(
                        key: promocodeKey,
                        child: TextFormField(
                          controller: promocodeController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Promocode";
                            }

                            for (var code in Globle.promocode) {
                              if (val != code["code"]) {
                                return "Enter Valid Code";
                              }
                            }

                            for (var code in Globle.promocode) {
                              if (code["stock"] <= 0) {
                                return "Promocode Expired";
                              }
                            }
                          },
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          child: const Text("Cancle"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        OutlinedButton(
                          child: const Text("Apply"),
                          onPressed: () {
                            if (promocodeKey.currentState!.validate()) {
                              Navigator.of(context).pop();
                              for (var code in Globle.promocode) {
                                if (code["code"] == promocodeController.text) {
                                  code["stock"]--;
                                  code["apply"] = true;
                                }
                              }
                            }
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: getAllData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<Product>? data2 = snapshot.data;

            for (var product in data2!) {
              if ("true" == product.isAdd) {
                Globle.cartData.add(product);
              }
            }

            return Column(
              children: [
                SizedBox(
                  height: 595,
                  width: _width,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemCount: Globle.cartData.length,
                    separatorBuilder: (context, i) => const SizedBox(height: 5),
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.amber[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(
                                  Globle.cartData[i].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Globle.cartData[i].productName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: const [
                                      Text(
                                        "India",
                                        style: TextStyle(
                                          color: Colors.black38,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                      Text(
                                        "Stock",
                                        style: TextStyle(
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "\$${Globle.cartData[i].price * Globle.cartData[i].count}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 55,
                                      ),
                                      Text(
                                        Globle.cartData[i].stock.toString(),
                                        style: const TextStyle(
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if (Globle.cartData[i].count <
                                              Globle.cartData[i].stock) {
                                            int cart =
                                                Globle.cartData[i].count + 1;
                                            Globle.cartData[i].count++;
                                            setState(() {});

                                            Map<String, dynamic> product = {
                                              "count": cart,
                                            };

                                            Product_Helper.product_helper
                                                .updateRecord(
                                              data: Product(
                                                id: Globle.cartData[i].id,
                                                image: Globle.cartData[i].image,
                                                productName: Globle
                                                    .cartData[i].productName,
                                                price: Globle.cartData[i].price,
                                                stock: Globle.cartData[i].stock,
                                                isAdd: "true",
                                                count: cart,
                                              ),
                                              id: Globle.cartData[i].id,
                                            );
                                          }
                                        },
                                        child: Ink(
                                          child: Container(
                                            height: 35,
                                            width: 40,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                left: Radius.circular(10),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "+",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 35,
                                        width: 50,
                                        color: const Color.fromARGB(
                                            255, 182, 181, 181),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${Globle.cartData[i].count}",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          if (Globle.cartData[i].count > 1) {
                                            int cart =
                                                Globle.cartData[i].count - 1;
                                            Globle.cartData[i].count--;
                                            setState(() {});
                                            Map<String, dynamic> product = {
                                              "count": cart,
                                            };

                                            Product_Helper.product_helper
                                                .updateRecord(
                                              data: Product(
                                                id: Globle.cartData[i].id,
                                                image: Globle.cartData[i].image,
                                                productName: Globle
                                                    .cartData[i].productName,
                                                price: Globle.cartData[i].price,
                                                stock: Globle.cartData[i].stock,
                                                isAdd: "true",
                                                count: cart,
                                              ),
                                              id: Globle.cartData[i].id,
                                            );
                                          }
                                        },
                                        child: Ink(
                                          child: Container(
                                            height: 35,
                                            width: 40,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                right: Radius.circular(10),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "-",
                                              style: TextStyle(fontSize: 30),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          Globle.cartData
                                              .remove(Globle.cartData[i]);
                                          setState(() {});
                                          Product_Helper.product_helper
                                              .updateRecord(
                                            data: Product(
                                              id: Globle.cartData[i].id,
                                              image: Globle.cartData[i].image,
                                              productName: Globle
                                                  .cartData[i].productName,
                                              price: Globle.cartData[i].price,
                                              stock: Globle.cartData[i].stock,
                                              isAdd: "false",
                                            ),
                                            id: Globle.cartData[i].id,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 100,
                  width: _width,
                  decoration: BoxDecoration(
                    color: const Color(0xffBAB63B),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 60),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            "\$$totalPrice",
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {});
                        },
                        child: Ink(
                          child: Container(
                            height: 50,
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Buy Now",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
