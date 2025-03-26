import '../models/product_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final Map<Product, int> cartItems;

  CartUpdated(this.cartItems);

  double get total => cartItems.entries
      .map((entry) => entry.key.discountedPrice * entry.value)
      .fold(0, (prev, curr) => prev + curr);
}
