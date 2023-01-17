// ignore_for_file: camel_case_types, non_constant_identifier_names, unused_local_variable

import 'package:final_project/model/coupon.dart';
import 'package:final_project/model/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Product_Helper {
  Product_Helper._();
  static final Product_Helper product_helper = Product_Helper._();

  Database? db;
  String dbName = "product.db";
  String productTable = "products";
  String couponTable = "coupon";
  String couponId = "id";
  String couponCode = "code";
  String couponStock = "stock";
  String couponApplay = "apply";
  String colIDAuto = "idAuto";
  String colID = "id";
  String colPrice = "price";
  String colProcuctName = "productName";
  String colCount = "count";
  String colImage = "image";
  String colStock = "stock";
  String colisAdd = "isAdd";

  Future<void> initDB() async {
    var directoryPath = await getDatabasesPath();
    String path = join(directoryPath, dbName);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String query =
            "CREATE TABLE IF NOT EXISTS $productTable($colIDAuto INTEGER PRIMARY KEY AUTOINCREMENT,$colID INTEGER, $colProcuctName TEXT , $colPrice INTEGER , $colCount INTEGER , $colImage TEXT ,$colStock INTEGER , $colisAdd TEXT)";
        await db.execute(query);

        String query2 =
            "CREATE TABLE IF NOT EXISTS $couponTable($couponId INTEGER PRIMARY KEY AUTOINCREMENT,$couponCode TEXT, $couponStock INTEGER ,$couponApplay TEXT)";
        await db.execute(query2);
      },
    );
  }

  Future<int?> insertRecord({required Product data}) async {
    await initDB();

    String query =
        "INSERT INTO $productTable($colID , $colProcuctName , $colPrice , $colCount , $colImage , $colStock , $colisAdd) VALUES(?,?,?,?,?,?,?)";
    List demo = [
      data.id,
      data.productName,
      data.price,
      data.count,
      data.image,
      data.stock,
      data.isAdd
    ];
    int? id = await db?.rawInsert(query, demo);

    return id;
  }

  Future<List<Product>> fetchRecord() async {
    await initDB();

    String query = "SELECT * FROM $productTable";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    List<Product> allProductData =
        data.map((e) => Product.fromMap(data: e)).toList();

    return allProductData;
  }

  Future<int> updateRecord({required Product data, required int id}) async {
    await initDB();

    String query = "UPDATE $productTable SET  $colisAdd=? WHERE $colIDAuto=?";
    List args = [data.isAdd, id];

    return db!.rawUpdate(query, args);
  }

  Future<int> deleteRecode({required int id}) async {
    await initDB();
    String query = "DELETE FROM $productTable WHERE $colIDAuto=?";
    List aegs = [id];

    return db!.rawDelete(query, aegs);
  }

  // Coupon Database
  Future<void> initCouponDB() async {
    var directoryPath = await getDatabasesPath();
    String path = join(directoryPath, dbName);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String query =
            "CREATE TABLE IF NOT EXISTS $couponTable($couponId INTEGER PRIMARY KEY AUTOINCREMENT,$couponCode TEXT, $couponStock INTEGER ,$couponApplay TEXT)";
        await db.execute(query);
      },
    );
  }

  Future<int?> insertCouponData({required Coupon data}) async {
    await initDB();

    String query =
        "INSERT INTO $couponTable($couponCode , $couponStock , $couponApplay) VALUES(?,?,?)";
    List demo = [
      data.code,
      data.stock,
      data.apply,
    ];
    int? id = await db?.rawInsert(query, demo);

    return id;
  }

  Future<int> updateCouponData({required Coupon data}) async {
    await initDB();

    String query =
        "UPDATE $couponTable SET $couponStock=? ,$couponApplay=?  WHERE $couponCode=?";
    List args = [data.stock, data.apply, data.code];

    return db!.rawUpdate(query, args);
  }

  Future<List<Coupon>> fetchCouponData() async {
    await initDB();

    String query = "SELECT * FROM $couponTable";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    List<Coupon> allCouponData =
        data.map((e) => Coupon.fromMap(data: e)).toList();

    return allCouponData;
  }
}
