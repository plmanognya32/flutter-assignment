import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/item_provider.dart';
import 'views/home_page.dart';
import 'views/add_item_screen.dart';
import 'views/item_detail_screen.dart';
import 'views/modify_item_screen.dart';

void main() {
  runApp(const ProductManagerApp());
}

class ProductManagerApp extends StatelessWidget {
  const ProductManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ItemProvider(),
      child: MaterialApp(
        title: 'Product Manager V2',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        routes: {
          AddItemScreen.routeName: (_) => const AddItemScreen(),
          ItemDetailScreen.routeName: (_) => const ItemDetailScreen(),
          ModifyItemScreen.routeName: (_) => const ModifyItemScreen(),
        },
      ),
    );
  }
}
