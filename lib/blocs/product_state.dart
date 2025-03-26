import 'package:havaizaada_technology_assignment/models/product_model.dart';

abstract class ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final bool isPaginating;

  ProductLoaded({required this.products, this.isPaginating = false});

  ProductLoaded copyWith({
    List<Product>? products,
    bool? isPaginating,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      isPaginating: isPaginating ?? this.isPaginating,
    );
  }
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
