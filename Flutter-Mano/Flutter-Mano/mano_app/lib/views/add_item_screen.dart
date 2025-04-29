import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/item_provider.dart';
import '../models/item.dart';

class AddItemScreen extends StatefulWidget {
  static const routeName = '/add';

  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';
  double price = 0.0;
  String imageUrl = '';

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newItem = Item(
        id: '',
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );
      await Provider.of<ItemProvider>(context, listen: false).addItem(newItem);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (val) => name = val!,
                validator:
                    (val) => val == null || val.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (val) => description = val!,
                validator:
                    (val) =>
                        val == null || val.isEmpty ? 'Enter description' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (val) => price = double.parse(val!),
                validator:
                    (val) => val == null || val.isEmpty ? 'Enter price' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image URL'),
                onSaved: (val) => imageUrl = val!,
                validator:
                    (val) =>
                        val == null || val.isEmpty ? 'Enter image URL' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveItem,
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
