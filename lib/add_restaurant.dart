import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/restaurant_list.dart';
import 'model/restaurant.dart';

class AddRestaurantPage extends StatefulWidget {
  @override
  _AddRestaurantPageState createState() => _AddRestaurantPageState();
}

class _AddRestaurantPageState extends State<AddRestaurantPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  List<Restaurant> restaurant = List.empty(growable: true);

  readFromSp() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    List<String>? restaurantListString = sp.getStringList('myData');
    if (restaurantListString != null) {
      restaurant = restaurantListString
          .map(
            (contact) => Restaurant.fromJson(
              json.decode(contact),
            ),
          )
          .toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    readFromSp();
  }

  saveIntoSp() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> restaurantListString = restaurant
        .map((restaurant) => jsonEncode(restaurant.toJson()))
        .toList();
    sp.setStringList('myData', restaurantListString);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RestaurantList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Restaurant'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Restaurant Name',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                decoration:
                    const InputDecoration(labelText: 'Restaurant Address'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String name = _nameController.text.trim();
                  String address = _addressController.text.trim();
                  if (name.isNotEmpty && address.isNotEmpty) {
                    var toBeAddedRestaurant = Restaurant(
                      name: name,
                      address: address,
                      imageUrl:
                      'https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg',
                    );
                    restaurant.add(toBeAddedRestaurant);
                    saveIntoSp();
                  }
else
  {
  }


                },
                child: const Text('Add Restaurant'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
