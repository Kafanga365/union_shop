import 'package:flutter/material.dart';
import 'package:union_shop/pages/home_page.dart';
import 'package:union_shop/pages/about_us_page.dart';
import 'package:union_shop/pages/collections_page.dart';
import 'package:union_shop/pages/collection_page.dart';
import 'package:union_shop/pages/sale_collection_page.dart';
import 'package:union_shop/pages/authentication_page.dart';
import 'package:union_shop/product_page.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomePage(),
      initialRoute: '/',
      routes: {
        '/product': (context) => const ProductPage(),
        '/about': (context) => const AboutUsPage(),
        '/collections': (context) => const CollectionsPage(),
        '/collection': (context) => const CollectionPage(),
        '/sale': (context) => const SaleCollectionPage(),
        '/auth': (context) => const AuthenticationPage(),
      },
    );
  }
}
