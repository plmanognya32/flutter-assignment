import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/item.dart';

class ItemProvider with ChangeNotifier {
  final String baseUrl = 'http://192.168.81.159:5000/products/items';

  List<Item> _items = [];

  List<Item> get items => [..._items];

  Item? getById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> fetchItems() async {
  try {
    final response = await http.get(Uri.parse(baseUrl));

    print('📦 Status Code: ${response.statusCode}');
    print('📦 Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      _items = data.map((item) => Item.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load items');
    }
  } catch (e) {
    print('❌ Error occurred while fetching items: $e');
    rethrow;
  }
}



  Future<void> addItem(Item item) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(item.toJson()),
      );
      if (response.statusCode == 201) {
        final newItem = Item.fromJson(jsonDecode(response.body));
        _items.add(newItem);
        notifyListeners();
      } else {
        throw Exception('Failed to add item');
      }
    } catch (error) {
      print('Error adding item: $error');
      rethrow;
    }
  }

  Future<void> updateItem(Item updated) async {
    try {
      final url = '$baseUrl/${updated.id}';
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updated.toJson()),
      );
      if (response.statusCode == 200) {
        final index = _items.indexWhere((item) => item.id == updated.id);
        if (index != -1) {
          _items[index] = updated;
          notifyListeners();
        }
      } else {
        throw Exception('Failed to update item');
      }
    } catch (error) {
      print('Error updating item: $error');
      rethrow;
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      final url = '$baseUrl/$id';
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        _items.removeWhere((item) => item.id == id);
        notifyListeners();
      } else {
        throw Exception('Failed to delete item');
      }
    } catch (error) {
      print('Error deleting item: $error');
      rethrow;
    }
  }
}
