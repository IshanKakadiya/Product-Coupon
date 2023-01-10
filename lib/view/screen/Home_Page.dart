// ignore_for_file: camel_case_types, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:final_project/helper/product_helper.dart';
import 'package:final_project/model/product.dart';
import 'package:flutter/material.dart';

import '../../res/globle.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

late Future<List<Product>> getAllData;

class _Home_PageState extends State<Home_Page> {
  @override
  void initState() {
    super.initState();
    getAllData = Product_Helper.product_helper.fetchRecord();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 219, 219, 219),
        child: FutureBuilder(
          future: getAllData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("ERROR : ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              List<Product>? data2 = snapshot.data;
              List<Product> data = [];

              for (var product in data2!) {
                if (Globle.addProductId == product.id) {
                  data.add(product);
                }
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        height: 260,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xffBAB63B),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(80),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 60),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                const Spacer(),
                                Image.asset(
                                  'assets/woman.png',
                                  height: 30,
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(10),
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.search),
                                  SizedBox(width: 15),
                                  Text(
                                    "Search foodstuffs",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: Globle.fruits.map((e) {
                                return InkWell(
                                  onTap: () {
                                    Globle.addProductId = e["id"];
                                    setState(() {});
                                  },
                                  child: Ink(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 210, left: 15),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 15),
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            e["image"],
                                            height: 30,
                                            width: 30,
                                          ),
                                          const Spacer(),
                                          Text(e["name"])
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Text(
                          "Popular Foodstuffs",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.of(context)
                                  .pushNamed('CartShoping_Page');
                            });
                          },
                          child: Ink(
                            child: Container(
                              height: 40,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 5),
                                  const Icon(
                                    size: 25,
                                    Icons.shopping_bag_outlined,
                                    color: Color.fromARGB(255, 57, 39, 39),
                                  ),
                                  const SizedBox(width: 2),
                                  Container(
                                    height: 33,
                                    width: 33,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffBAB63B),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "4",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                  Container(
                    height: _height * 0.535,
                    width: _width,
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      itemCount: data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 7,
                        mainAxisSpacing: 7,
                      ),
                      itemBuilder: (context, i) {
                        return Container(
                          padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 0,
                            left: 15,
                            right: 0,
                          ),
                          height: 185,
                          width: 157,
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    data[i].image,
                                    width: 70,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                data[i].productName,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    "\$${data[i].price} /-",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () async {
                                      if (data[i].isAdd == "false") {
                                        // Map<String, dynamic> product = {
                                        //   // "id": productData[i]["id"],
                                        //   // "productName": productData[i]
                                        //   //     // ["productName"],
                                        //   // "image": productData[i]
                                        //   //     ["image"],
                                        //   // "price": productData[i]
                                        //   //     ["price"],
                                        //   // "stock": productData[i]
                                        //   //     ["stock"],
                                        //   "count":
                                        //       (productData[i]["count"] == 0)
                                        //           ? 1
                                        //           : productData[i]["count"],
                                        //   "isAdd": true,
                                        // };
                                        // await AddProdutsHelper.addProdutsHelper
                                        //     .updateProduct(
                                        //         product: product,
                                        //         id: productData[i].id);
                                      }
                                    },
                                    child: Ink(
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffBAB63B),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "+",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
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
      ),
    );
  }
}
