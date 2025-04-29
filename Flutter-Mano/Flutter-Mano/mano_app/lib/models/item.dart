class Item {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id'] ?? '', // Safe fallback
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
