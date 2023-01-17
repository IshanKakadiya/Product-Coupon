class Coupon {
  final String code;
  int stock;
  String apply;

  Coupon({
    required this.code,
    required this.stock,
    this.apply = "false",
  });

  factory Coupon.fromMap({required Map<String, dynamic> data}) {
    return Coupon(
      code: data["code"],
      stock: data["stock"],
    );
  }
}
