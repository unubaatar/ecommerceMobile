import 'product.dart';
import 'productVariant.dart';

class CartItem {
  final String id;
  final Product product;
  final ProductVariant? variant;
  final int qty;
  final int? salePrice;
  final int price;
  final String customer;

  CartItem({
    required this.id,
    required this.product,
    this.variant,
    required this.qty,
    required this.price,
    this.salePrice,
    required this.customer,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['_id'],
      product:  Product.fromJson(json['product']),
      variant: json['variant'] != null ? ProductVariant.fromJson(json['variant']) : null,
      qty: json['qty'],
      salePrice: json['salePrice'],
      price: json['price'],
      customer: json['customer'],
    );
  }
}