import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';

// Cart Events
abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final int productId;
  RemoveFromCart(this.productId);
}

class UpdateQuantity extends CartEvent {
  final int productId;
  final int quantity;
  UpdateQuantity(this.productId, this.quantity);
}

// Cart State
class CartState {
  final List<Product> cartItems;
  CartState(this.cartItems);

  // Calculate total cost
  double get totalAmount => cartItems.fold(
      0, (sum, item) => sum + (item.discountedPrice * item.quantity));

  // Calculate total items in cart
  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);
}

// Cart BLoC
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([])) {
    // Add to cart logic
    on<AddToCart>((event, emit) {
      final updatedCart = List<Product>.from(state.cartItems);
      final index =
          updatedCart.indexWhere((item) => item.id == event.product.id);

      if (index != -1) {
        updatedCart[index] = updatedCart[index].copyWith(
          quantity: updatedCart[index].quantity + 1,
        );
      } else {
        updatedCart.add(event.product);
      }
      emit(CartState(updatedCart));
    });

    // Remove item from cart
    on<RemoveFromCart>((event, emit) {
      final updatedCart =
          state.cartItems.where((item) => item.id != event.productId).toList();
      emit(CartState(updatedCart));
    });

    // Update quantity logic
    on<UpdateQuantity>((event, emit) {
      final updatedCart = state.cartItems.map((item) {
        if (item.id == event.productId) {
          return item.copyWith(quantity: event.quantity);
        }
        return item;
      }).toList();
      emit(CartState(updatedCart));
    });
  }
}
