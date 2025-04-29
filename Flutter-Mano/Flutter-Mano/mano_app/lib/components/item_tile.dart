import 'package:flutter/material.dart';
import '../models/item.dart';
import '../views/item_detail_screen.dart';

class ItemTile extends StatelessWidget {
  final Item item;

  const ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        item.imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(item.name),
      subtitle: Text('₹${item.price.toStringAsFixed(2)}'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.pushNamed(
          context,
          ItemDetailScreen.routeName,
          arguments: item.id,
        );
      },
    );
  }
}
