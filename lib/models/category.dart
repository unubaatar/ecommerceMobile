class Category {
  final String id;
  final String name;
  final String? image;
  final bool isActive;
  final String createdAt;

  Category({
    required this.id,
    required this.name,
    this.image,
    required this.isActive,
    required this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
    );
  }
}