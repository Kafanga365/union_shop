import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/services/data_service.dart';

/// Collection page displaying products within a specific collection
/// with functional sorting and filtering
class CollectionPage extends StatefulWidget {
  final String collectionId;

  const CollectionPage({
    super.key,
    this.collectionId = 'essential-range',
  });

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  late String _sortBy = 'Featured';
  late String _sizeFilter = 'All Sizes';
  late String _colorFilter = 'All Colors';
  late String _priceFilter = 'All Prices';
  late List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _updateFilteredProducts();
  }

  void _updateFilteredProducts() {
    final collection = DataService.getCollectionById(widget.collectionId);
    List<Product> products = collection?.products ?? [];

    // Apply size filter
    if (_sizeFilter != 'All Sizes') {
      products = products.where((p) => p.sizes.contains(_sizeFilter)).toList();
    }

    // Apply color filter
    if (_colorFilter != 'All Colors') {
      products =
          products.where((p) => p.colors.contains(_colorFilter)).toList();
    }

    // Apply price filter
    if (_priceFilter != 'All Prices') {
      products = products.where((p) {
        final price = p.displayPrice;
        switch (_priceFilter) {
          case 'Under £10':
            return price < 10;
          case '£10 - £20':
            return price >= 10 && price < 20;
          case '£20 - £30':
            return price >= 20 && price < 30;
          case 'Over £30':
            return price >= 30;
          default:
            return true;
        }
      }).toList();
    }

    // Apply sorting
    switch (_sortBy) {
      case 'Price: Low to High':
        products.sort((a, b) => a.displayPrice.compareTo(b.displayPrice));
        break;
      case 'Price: High to Low':
        products.sort((a, b) => b.displayPrice.compareTo(a.displayPrice));
        break;
      case 'Newest':
        products.sort((a, b) => b.id.compareTo(a.id));
        break;
      case 'Featured':
      default:
        // Keep original order
        break;
    }

    setState(() {
      _filteredProducts = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    final collection = DataService.getCollectionById(widget.collectionId);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            const AppHeader(),

            // Collection Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    collection?.name ?? 'Collection',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (collection != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      collection.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),

            // Filters and Sorting Section
            Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdown(
                          'Sort By',
                          [
                            'Featured',
                            'Price: Low to High',
                            'Price: High to Low',
                            'Newest'
                          ],
                          _sortBy,
                          (value) {
                            setState(() {
                              _sortBy = value;
                              _updateFilteredProducts();
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDropdown(
                          'Filter by Size',
                          ['All Sizes', 'S', 'M', 'L', 'XL', 'XXL'],
                          _sizeFilter,
                          (value) {
                            setState(() {
                              _sizeFilter = value;
                              _updateFilteredProducts();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdown(
                          'Filter by Color',
                          [
                            'All Colors',
                            'Black',
                            'White',
                            'Sage',
                            'Pink',
                            'Navy'
                          ],
                          _colorFilter,
                          (value) {
                            setState(() {
                              _colorFilter = value;
                              _updateFilteredProducts();
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDropdown(
                          'Filter by Price',
                          [
                            'All Prices',
                            'Under £10',
                            '£10 - £20',
                            '£20 - £30',
                            'Over £30'
                          ],
                          _priceFilter,
                          (value) {
                            setState(() {
                              _priceFilter = value;
                              _updateFilteredProducts();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Products Count
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              width: double.infinity,
              child: Text(
                '${_filteredProducts.length} product${_filteredProducts.length != 1 ? 's' : ''}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),

            // Products Grid
            if (_filteredProducts.isNotEmpty)
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(24),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 2 : 1,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 32,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    return _ProductCard(product: _filteredProducts[index]);
                  },
                ),
              )
            else
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(48),
                width: double.infinity,
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
                    const SizedBox(height: 16),
                    Text(
                      'No products match your filters',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try adjusting your search criteria',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
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

  Widget _buildDropdown(
    String label,
    List<String> options,
    String currentValue,
    Function(String) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<String>(
        value: currentValue,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        items: options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
      ),
    );
  }
}

/// Product card widget for displaying individual products
class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: product.id);
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[200],
              child: product.imageUrl.isNotEmpty
                  ? Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(Icons.image_not_supported,
                              color: Colors.grey[400]),
                        );
                      },
                    )
                  : Center(
                      child: Icon(Icons.shopping_bag,
                          size: 48, color: Colors.grey[400]),
                    ),
            ),
            const SizedBox(height: 16),

            // Product Name
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Price
            Row(
              children: [
                if (product.hasDiscount)
                  Text(
                    '£${product.originalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                if (product.hasDiscount) const SizedBox(width: 8),
                Text(
                  '£${product.displayPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: product.hasDiscount ? Colors.red : Colors.black87,
                  ),
                ),
              ],
            ),

            // Discount Badge
            if (product.hasDiscount) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red[600],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '-${product.discountPercentage.toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],

            const Spacer(),

            // Add to Cart Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF4d2963),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Center(
                child: Text(
                  'ADD TO CART',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
