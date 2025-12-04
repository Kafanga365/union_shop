import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/providers/cart_provider.dart';

/// Reusable header widget with banner and navigation icons
class AppHeader extends StatelessWidget {
  final String bannerText;

  const AppHeader({
    super.key,
    this.bannerText =
        'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF!',
  });

  void _navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _placeholderCallback() {
    // Placeholder for buttons that don't work yet
  }

  void _navigateToAuth(BuildContext context) {
    Navigator.pushNamed(context, '/auth');
  }

  void _navigateToCart(BuildContext context) {
    Navigator.pushNamed(context, '/cart');
  }

  void _navigateToSearch(BuildContext context) {
    Navigator.pushNamed(context, '/search');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Top banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4d2963),
            child: Text(
              bannerText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Main header
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Logo
                GestureDetector(
                  onTap: () => _navigateToHome(context),
                  child: Image.network(
                    'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                    height: 40,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        width: 40,
                        height: 40,
                        child: const Center(
                          child: Icon(Icons.store, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
                // Navigation icons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search, size: 20),
                      color: Colors.grey[700],
                      onPressed: () => _navigateToSearch(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person_outline, size: 20),
                      color: Colors.grey[700],
                      onPressed: () => _navigateToAuth(context),
                    ),
                    Consumer<CartProvider>(
                      builder: (context, cart, _) {
                        return Stack(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.shopping_bag_outlined,
                                  size: 20),
                              color: Colors.grey[700],
                              onPressed: () => _navigateToCart(context),
                            ),
                            if (cart.itemCount > 0)
                              Positioned(
                                top: 6,
                                right: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    cart.itemCount > 99
                                        ? '99+'
                                        : cart.itemCount.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.menu, size: 20),
                      color: Colors.grey[700],
                      onPressed: _placeholderCallback,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
