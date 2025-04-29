import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/item_provider.dart';
import '../components/item_tile.dart';
import 'add_item_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await Provider.of<ItemProvider>(context, listen: false).fetchItems();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemProvider>(context).items;

    return Scaffold(
      appBar: AppBar(title: const Text('Product Manager')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : items.isEmpty
              ? const Center(child: Text('No products found.'))
              : ListView.builder(
                itemCount: items.length,
                itemBuilder: (ctx, index) => ItemTile(item: items[index]),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AddItemScreen.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }
}
