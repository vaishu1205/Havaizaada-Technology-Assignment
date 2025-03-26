import '../models/product_model.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final int productId;
  RemoveFromCart(this.productId);
}
