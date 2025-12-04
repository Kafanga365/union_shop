import '../models/product.dart';
import '../models/collection.dart';

/// Dummy data service providing hardcoded products and collections
/// This will be replaced with real data fetching in intermediate/advanced features
class DataService {
  /// Get all products
  static List<Product> getAllProducts() {
    return [
      // Essential Range - Sale Items
      Product(
        id: 'essential-hoodie-1',
        name: 'Limited Edition Essential Zip Hoodie',
        description:
            'Comfortable zip hoodie from our Essential Range. Available in multiple colors.',
        price: 20.00,
        salePrice: 14.99,
        imageUrl:
            'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=500',
        category: 'Essential Range',
        sizes: ['S', 'M', 'L', 'XL'],
        colors: ['Pink', 'Sage', 'Black'],
        isOnSale: true,
      ),
      Product(
        id: 'essential-tshirt-1',
        name: 'Essential T-Shirt',
        description:
            'Classic t-shirt from our Essential Range. Perfect for everyday wear.',
        price: 10.00,
        salePrice: 6.99,
        imageUrl:
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500',
        category: 'Essential Range',
        sizes: ['S', 'M', 'L', 'XL'],
        colors: ['Sage', 'White', 'Black'],
        isOnSale: true,
      ),

      // Signature Range
      Product(
        id: 'signature-hoodie-1',
        name: 'Signature Hoodie',
        description:
            'Premium hoodie from our Signature Range. High quality material and design.',
        price: 32.99,
        imageUrl:
            'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=500',
        category: 'Signature Range',
        sizes: ['S', 'M', 'L', 'XL', 'XXL'],
        colors: ['Sage', 'Navy', 'Black'],
      ),
      Product(
        id: 'signature-tshirt-1',
        name: 'Signature T-Shirt',
        description: 'Premium t-shirt from our Signature Range.',
        price: 14.99,
        imageUrl:
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500',
        category: 'Signature Range',
        sizes: ['S', 'M', 'L', 'XL'],
        colors: ['Indigo Blue', 'White', 'Black'],
      ),

      // Portsmouth City Collection
      Product(
        id: 'portsmouth-magnet-1',
        name: 'Portsmouth City Magnet',
        description:
            'Beautiful Portsmouth city magnet featuring iconic landmarks.',
        price: 4.50,
        imageUrl:
            'https://images.unsplash.com/photo-1513885535751-8b9238bd345a?w=500',
        category: 'Portsmouth City Collection',
      ),
      Product(
        id: 'portsmouth-postcard-1',
        name: 'Portsmouth City Postcard',
        description: 'Collectible postcard featuring Portsmouth city views.',
        price: 1.00,
        imageUrl:
            'https://images.unsplash.com/photo-1513885535751-8b9238bd345a?w=500',
        category: 'Portsmouth City Collection',
      ),
      Product(
        id: 'portsmouth-bookmark-1',
        name: 'Portsmouth City Bookmark',
        description: 'Decorative bookmark with Portsmouth city theme.',
        price: 3.00,
        imageUrl:
            'https://images.unsplash.com/photo-1513885535751-8b9238bd345a?w=500',
        category: 'Portsmouth City Collection',
      ),
      Product(
        id: 'portsmouth-notebook-1',
        name: 'Portsmouth City Notebook',
        description: 'Quality notebook featuring Portsmouth city design.',
        price: 7.50,
        imageUrl:
            'https://images.unsplash.com/photo-1513885535751-8b9238bd345a?w=500',
        category: 'Portsmouth City Collection',
      ),
    ];
  }

  /// Get all collections
  static List<Collection> getAllCollections() {
    final products = getAllProducts();

    return [
      Collection(
        id: 'essential-range',
        name: 'Essential Range',
        description: 'Over 20% OFF! Our Essential Range at incredible prices.',
        imageUrl:
            'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=500',
        products:
            products.where((p) => p.category == 'Essential Range').toList(),
      ),
      Collection(
        id: 'signature-range',
        name: 'Signature Range',
        description: 'Premium quality signature products.',
        imageUrl:
            'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=500',
        products:
            products.where((p) => p.category == 'Signature Range').toList(),
      ),
      Collection(
        id: 'portsmouth-city',
        name: 'Portsmouth City Collection',
        description: 'Beautiful Portsmouth city-themed merchandise.',
        imageUrl:
            'https://images.unsplash.com/photo-1513885535751-8b9238bd345a?w=500',
        products: products
            .where((p) => p.category == 'Portsmouth City Collection')
            .toList(),
      ),
    ];
  }

  /// Get products on sale
  static List<Product> getSaleProducts() {
    return getAllProducts().where((p) => p.isOnSale).toList();
  }

  /// Get products by category
  static List<Product> getProductsByCategory(String category) {
    return getAllProducts().where((p) => p.category == category).toList();
  }

  /// Get product by ID
  static Product? getProductById(String id) {
    try {
      return getAllProducts().firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get collection by ID
  static Collection? getCollectionById(String id) {
    try {
      return getAllCollections().firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }
}
