import 'brand.dart';
import 'category.dart';

class Product {
  final String id;  
  final String name;
  final bool isActive;
  final int? sellPrice;
  final int price;
  final String createdAt;
  final String updatedAt;
  final Brand? brand;
  final Category? category;
  final List? thumbnails;

  Product({
    required this.id,
    required this.name,
    required this.isActive,
    this.sellPrice,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    this.brand,
    this.category,
    this.thumbnails
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      isActive: json['isActive'],
      sellPrice: json['sellPrice'],
      price: json['price'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      brand: Brand.fromJson(json['brand']),
      category: Category.fromJson(json['category']),
      thumbnails: json['thumbnails']
    );
  }
}
