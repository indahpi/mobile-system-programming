import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String apiUrl = 'https://fakestoreapi.com/products';

  // Fungsi Fetch All Products (Langkah sebelumnya)
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((jsonItem) => Product.fromJson(jsonItem)).toList();
      } else {
        throw Exception('Gagal memuat produk dari server (Status: ${response.statusCode})');
      }
    } catch (e) {
      rethrow;
    }
  }

  // TUGAS MANDIRI 1: Fungsi Fetch Single Product Detail berdasarkan ID
  Future<Product> fetchProductDetail(int id) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$id'));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return Product.fromJson(jsonMap);
      } else {
        throw Exception('Gagal memuat detail produk (Status: ${response.statusCode})');
      }
    } catch (e) {
      rethrow;
    }
  }
}