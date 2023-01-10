import 'package:final_project/res/globle.dart';
import 'package:final_project/view/screen/Home_Page.dart';
import 'package:final_project/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Provider/cart_Provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prep = await SharedPreferences.getInstance();
  Globle.data = prep.getBool('data') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash_screen',
        routes: {
          '/': (context) => const Home_Page(),
          'splash_screen': (context) => const splash_screen(),
        },
      ),
    ),
  );
}
