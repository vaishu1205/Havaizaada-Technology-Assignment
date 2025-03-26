abstract class ProductEvent {}

class FetchProductsEvent extends ProductEvent {
  final int limit;
  final int skip;

  FetchProductsEvent({required this.limit, required this.skip});
}
