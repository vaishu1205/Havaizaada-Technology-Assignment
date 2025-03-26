

class Product {
  final int id;
  final String name;
  final String image;
  final double price;
  final double discountedPrice;
  final int discount;
  int quantity; 

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.discountedPrice,
    required this.discount,
    this.quantity = 1, 
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    double price = (json['price'] as num).toDouble();
    int discount = (json['discountPercentage'] as num).toInt();
    double discountedPrice = price - (price * discount / 100);

    return Product(
      id: json['id'],
      name: json['title'],
      image: json['thumbnail'],
      price: price,
      discountedPrice: discountedPrice,
      discount: discount,
    );
  }

 
  Product copyWith({int? quantity}) {
    return Product(
      id: id,
      name: name,
      image: image,
      price: price,
      discountedPrice: discountedPrice,
      discount: discount,
      quantity: quantity ?? this.quantity,
    );
  }
}
