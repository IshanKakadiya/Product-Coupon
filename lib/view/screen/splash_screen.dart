// ignore_for_file: camel_case_types, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unused_local_variable, avoid_function_literals_in_foreach_calls

import 'package:final_project/helper/product_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../res/globle.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const Text(
              "Get\nOrganic Food",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Find the freshest food and get\nfree delivery in your town",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () async {
                SharedPreferences pres = await SharedPreferences.getInstance();

                if (Globle.data == false) {
                  Globle.products.forEach((e) {
                    Product_Helper.product_helper.insertRecord(data: e);
                  });

                  print("--------");
                  print("--------");
                  print("--------");

                  Navigator.of(context).pushReplacementNamed('/');
                  pres.setBool('data', true);
                } else {
                  Navigator.of(context).pushReplacementNamed('/');
                }
              },
              child: Ink(
                child: Container(
                  height: 50,
                  width: 240,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      color: Color(0xff84801F),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
            Image.asset(
              "assets/buyer.png",
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xffBAB63B),
    );
  }
}
