class Restaurant {
  String name;
  String address;
  String imageUrl;

  Restaurant({
    required this.name,
    required this.address,
    required this.imageUrl,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      address: json['address'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'imageUrl': imageUrl,
    };
  }
}
