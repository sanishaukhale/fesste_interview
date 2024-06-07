class Items {
  int id;
  String title;
  double price;
  String image;

  Items({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}
