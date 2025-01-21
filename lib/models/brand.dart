class Brand {
  final String id;
  final String name;
  final String? image;
  final bool isActive;
  final String createdAt;

  Brand({
    required this.id,
    required this.name,
    this.image,
    required this.isActive,
    required this.createdAt,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
    );
  }
}