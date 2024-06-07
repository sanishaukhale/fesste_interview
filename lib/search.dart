import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '/restaurant_list.dart';
import 'model/items.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Items> _items = [];

  List<Items> _filteredItems = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchItems();
    _searchController.addListener(() {
      filterItems();
    });
  }

  Future<void> fetchItems() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _items = data.map((item) => Items.fromJson(item)).toList();
        _filteredItems = _items;
      });
    } else {
      throw Exception('Failed to load items');
    }
  }

  void filterItems() {
    List<Items> results = [];
    if (_searchController.text.isEmpty) {
      results = _items;
    } else {
      results = _items
          .where(
            (item) => item.title.toLowerCase().startsWith(
                  _searchController.text.toLowerCase(),
                ),
          )
          .toList();
    }
    setState(() {
      _filteredItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Items'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const RestaurantList(),
            ),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _filteredItems.isEmpty
                ? const Center(
                    child: Text(
                      'No matching items found',
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(
                          _filteredItems[index].image,
                          height: 100,
                          width: 100,
                        ),
                        title: Text(
                          _filteredItems[index].title,
                        ),
                        subtitle: Text(
                          '\$${_filteredItems[index].price}',
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
