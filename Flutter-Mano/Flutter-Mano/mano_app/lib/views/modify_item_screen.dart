import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/item_provider.dart';
import '../models/item.dart';

class ModifyItemScreen extends StatefulWidget {
  static const routeName = '/edit';

  const ModifyItemScreen({super.key});

  @override
  State<ModifyItemScreen> createState() => _ModifyItemScreenState();
}

class _ModifyItemScreenState extends State<ModifyItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late Item editableItem;
  late String name;
  late String description;
  late double price;
  late String imageUrl;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final itemId = ModalRoute.of(context)!.settings.arguments as String;
    editableItem =
        Provider.of<ItemProvider>(context, listen: false).getById(itemId)!;
    name = editableItem.name;
    description = editableItem.description;
    price = editableItem.price;
    imageUrl = editableItem.imageUrl;
  }

  void _updateItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final updated = Item(
        id: editableItem.id,
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );
      await Provider.of<ItemProvider>(
        context,
        listen: false,
      ).updateItem(updated);
      Navigator.pop(context);
    }
  }

  void _deleteItem() async {
    await Provider.of<ItemProvider>(
      context,
      listen: false,
    ).deleteItem(editableItem.id);
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (val) => name = val!,
                validator:
                    (val) => val == null || val.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (val) => description = val!,
                validator:
                    (val) =>
                        val == null || val.isEmpty ? 'Enter description' : null,
              ),
              TextFormField(
                initialValue: price.toString(),
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (val) => price = double.parse(val!),
                validator:
                    (val) => val == null || val.isEmpty ? 'Enter price' : null,
              ),
              TextFormField(
                initialValue: imageUrl,
                decoration: const InputDecoration(labelText: 'Image URL'),
                onSaved: (val) => imageUrl = val!,
                validator:
                    (val) =>
                        val == null || val.isEmpty ? 'Enter image URL' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateItem,
                child: const Text('Update Product'),
              ),
              TextButton(
                onPressed: _deleteItem,
                child: const Text(
                  'Delete Product',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
