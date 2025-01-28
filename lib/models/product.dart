import 'brand.dart';
import 'category.dart';
import 'productVariant.dart';

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
  // final List? variants;
  final List<ProductVariant>? variants;

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
    this.thumbnails,
    this.variants,
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
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      thumbnails: json['thumbnails'],
      // variants: json['variants'],
      variants: json['variants'] != null
          ? List<ProductVariant>.from(
              json['variants'].map((variant) => ProductVariant.fromJson(variant)),
            )
          : null,

    );
  }
}
