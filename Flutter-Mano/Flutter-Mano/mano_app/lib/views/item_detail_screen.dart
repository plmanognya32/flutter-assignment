import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/item_provider.dart';
import '../models/item.dart';
import 'modify_item_screen.dart';

class ItemDetailScreen extends StatelessWidget {
  static const routeName = '/details';

  const ItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context)!.settings.arguments as String;
    final item = Provider.of<ItemProvider>(context).getById(itemId);

    if (item == null) {
      return const Scaffold(body: Center(child: Text('Product not found')));
    }

    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(item.imageUrl, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              '₹${item.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 8),
            Text(item.description),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ModifyItemScreen.routeName,
                  arguments: item.id,
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit Product'),
            ),
          ],
        ),
      ),
    );
  }
}
