import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/add_restaurant.dart';
import '/search.dart';
import 'model/restaurant.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({super.key});

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  List<Restaurant> sharedPrefRestaurants = List.empty(growable: true);

  late List<Restaurant> restaurants = [
    Restaurant(
      name: 'Coastal Breeze Cafe',
      address: '104, Beach Road, Anjuna, Goa 403509',
      imageUrl:
          'https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg',
    ),
    Restaurant(
      name: 'Sunset Grill',
      address: 'Calangute Road, Baga, Goa 403516',
      imageUrl:
          'https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg',
    ),
    Restaurant(
      name: 'Spice Garden',
      address: '55, Market Street, Panjim, Goa 403001',
      imageUrl:
          'https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg',
    ),
  ];

  readFromSp() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    List<String>? restaurantListString = sp.getStringList('myData');
    if (restaurantListString != null) {
      sharedPrefRestaurants = restaurantListString
          .map((contact) => Restaurant.fromJson(json.decode(contact)))
          .toList();
    }
    restaurants = restaurants + sharedPrefRestaurants;
    setState(() {});
  }

  @override
  void initState() {
    readFromSp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              restaurants[index].imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(restaurants[index].name),
            subtitle: Text(restaurants[index].address),
          );
        },
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
                child: const Icon(Icons.search),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                heroTag: "btn2",
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddRestaurantPage(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
