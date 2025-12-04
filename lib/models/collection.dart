import 'product.dart';

/// Collection model representing a group of products
class Collection {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<Product> products;

  Collection({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.products,
  });

  /// Get products count in this collection
  int get productCount => products.length;
}
