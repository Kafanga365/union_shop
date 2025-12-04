import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/pages/home_page.dart';
import 'package:union_shop/pages/about_us_page.dart';
import 'package:union_shop/pages/collections_page.dart';
import 'package:union_shop/pages/collection_page.dart';
import 'package:union_shop/pages/sale_collection_page.dart';
import 'package:union_shop/pages/authentication_page.dart';
import 'package:union_shop/pages/cart_page.dart';
import 'package:union_shop/pages/personalisation_page.dart';
import 'package:union_shop/pages/search_page.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/providers/cart_provider.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
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
          '/cart': (context) => const CartPage(),
          '/personalisation': (context) => const PersonalisationPage(),
          '/search': (context) => const SearchPage(),
        },
      ),
    );
  }
}
