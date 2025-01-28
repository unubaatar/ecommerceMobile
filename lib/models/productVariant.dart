class ProductVariant {
  final String id;
  final String name;
  final int?  sellPrice;
  final int price;
  final List? images;

  ProductVariant({
    required this.id,
    required this.name,
    this.sellPrice,
    required this.price,
    this.images
  });

  factory ProductVariant.fromJson(Map<String , dynamic> json) {
    return ProductVariant(
      id: json['_id'],
      name: json['name'],
      images: json['images'],
      sellPrice: json['sellPrice'],
      price: json['price'],
    );
  }
}