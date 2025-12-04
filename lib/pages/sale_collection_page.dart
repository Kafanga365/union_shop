import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/services/data_service.dart';
import 'package:union_shop/models/product.dart';

/// Sale collection page showing discounted products with promotional messaging
class SaleCollectionPage extends StatelessWidget {
  const SaleCollectionPage({super.key});

  void _placeholderCallback() {
    // Placeholder for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    final saleProducts = DataService.getSaleProducts();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            const AppHeader(),

            // Promotional Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: Column(
                children: [
                  const Text(
                    'MASSIVE SALE!',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'UP TO 25% OFF SELECTED ITEMS',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Limited time only! Stock is running out fast.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _placeholderCallback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      'SHOP SALE NOW',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Sale Products Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              child: Column(
                children: [
                  Text(
                    '${saleProducts.length} Items on Sale',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Sale Products Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 32,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: saleProducts.length,
                    itemBuilder: (context, index) {
                      return _SaleProductCard(product: saleProducts[index]);
                    },
                  ),
                ],
              ),
            ),

            // Final Promotional Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.red[50],
                border: Border(
                  top: BorderSide(color: Colors.red[300]!, width: 2),
                  bottom: BorderSide(color: Colors.red[300]!, width: 2),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Don\'t Miss Out!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Sale ends soon. Grab your favorites before they\'re gone!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _placeholderCallback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      'CONTINUE SHOPPING',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Footer
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

/// Sale product card with discount highlight
class _SaleProductCard extends StatelessWidget {
  final Product product;

  const _SaleProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                            size: 48,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Product name
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Product price
              Row(
                children: [
                  Text(
                    '£${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '£${product.displayPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Discount badge
          if (product.hasDiscount)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '-${product.discountPercentage}%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
