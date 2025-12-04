import 'product.dart';

/// Cart item representing a product in the shopping cart
class CartItem {
  final Product product;
  final String? selectedSize;
  final String? selectedColor;
  int quantity;

  CartItem({
    required this.product,
    this.selectedSize,
    this.selectedColor,
    this.quantity = 1,
  });

  /// Get the total price for this cart item
  double get totalPrice => product.displayPrice * quantity;

  /// Create a copy of this cart item with modified fields
  CartItem copyWith({
    Product? product,
    String? selectedSize,
    String? selectedColor,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      quantity: quantity ?? this.quantity,
    );
  }
}
