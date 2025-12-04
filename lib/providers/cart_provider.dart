import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

/// Cart provider/service for managing shopping cart state
class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  /// Get number of items in cart
  int get itemCount => _items.length;

  /// Get total number of products (considering quantities)
  int get totalQuantity => _items.fold(0, (sum, item) => sum + item.quantity);

  /// Get total price of all items
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

  /// Add item to cart
  void addToCart(
    Product product, {
    String? selectedSize,
    String? selectedColor,
    int quantity = 1,
  }) {
    // Check if product with same size/color already exists
    final existingIndex = _items.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedSize == selectedSize &&
          item.selectedColor == selectedColor,
    );

    if (existingIndex != -1) {
      // Update quantity if item exists
      _items[existingIndex].quantity += quantity;
    } else {
      // Add new item
      _items.add(
        CartItem(
          product: product,
          selectedSize: selectedSize,
          selectedColor: selectedColor,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  /// Remove item from cart by index
  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  /// Update quantity of item at index
  void updateQuantity(int index, int quantity) {
    if (index >= 0 && index < _items.length && quantity > 0) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  /// Clear entire cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// Check if product is in cart
  bool isInCart(String productId) {
    return _items.any((item) => item.product.id == productId);
  }
}
