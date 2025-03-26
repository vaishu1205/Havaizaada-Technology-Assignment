import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductRepository {
  final String apiUrl = 'https://dummyjson.com/products';


  Future<List<Product>> fetchProducts({int limit = 10, int skip = 0}) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl?limit=$limit&skip=$skip'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data.containsKey('products')) {
          List<dynamic> productsJson = data['products'];

          return productsJson.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception('Invalid API response format');
        }
      } else {
        throw Exception('Failed to load products (Status: ${response.statusCode})');
      }
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Error loading products');
    }
  }
}
