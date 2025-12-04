/// Product model representing a single product in the shop
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? salePrice;
  final String imageUrl;
  final List<String> additionalImages;
  final String category;
  final List<String> sizes;
  final List<String> colors;
  final bool isOnSale;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.salePrice,
    required this.imageUrl,
    this.additionalImages = const [],
    required this.category,
    this.sizes = const [],
    this.colors = const [],
    this.isOnSale = false,
  });

  /// Get the display price (sale price if available, otherwise regular price)
  double get displayPrice => salePrice ?? price;

  /// Get the original price (always returns the regular price)
  double get originalPrice => price;

  /// Check if product has a discount
  bool get hasDiscount => salePrice != null && salePrice! < price;

  /// Calculate discount percentage
  int get discountPercentage {
    if (!hasDiscount) return 0;
    return (((price - salePrice!) / price) * 100).round();
  }
}
