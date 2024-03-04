import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  final String? id;
  final String name;
  final String description;
  final String price;

  Product({
     this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
  };
}