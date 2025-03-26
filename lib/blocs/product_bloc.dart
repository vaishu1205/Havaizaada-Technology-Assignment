import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

// Product Events
abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

// Product State
abstract class ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

// Product BLoC
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoading()) {
    on<FetchProducts>(_fetchProducts);
  }

  Future<void> _fetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['products'] as List;
        final products = data.map((json) => Product.fromJson(json)).toList();
        emit(ProductLoaded(products));
      } else {
        emit(ProductError('Failed to load products'));
      }
    } catch (e) {
      emit(ProductError('Error: $e'));
    }
  }
}
