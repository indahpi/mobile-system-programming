import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../controllers/cart_controller.dart';
import '../services/product_service.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductService _productService = ProductService();
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _loadProducts(); // Panggil data saat halaman pertama dibuka
  }

  // Method untuk memuat / memuat ulang data (untuk Tombol Coba Lagi)
  void _loadProducts() {
    setState(() {
      _futureProducts = _productService.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Biru (Utuh seperti semula)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 50.0,
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'TokoKita',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Kebutuhan Sekolah & Kantor Lengkap',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Obx(() => Stack(
                      alignment: Alignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shopping_cart, size: 28, color: Colors.white),
                          tooltip: 'Keranjang',
                          onPressed: () {
                            Get.to(() => const CartPage());
                          },
                        ),
                        if (cartController.totalItem > 0)
                          Positioned(
                            right: 4,
                            top: 4,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${cartController.totalItem}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    )),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.login, size: 28, color: Colors.white),
                      tooltip: 'Login',
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Body dengan FutureBuilder, penanganan error, dan Tombol Coba Lagi
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // 1. Kondisi Error & Tombol Coba Lagi (Langkah 5)
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: Colors.red),
                          const SizedBox(height: 12),
                          Text(
                            'Gagal memuat produk:\n${snapshot.error}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _loadProducts, // TOMBOL COBA LAGI (SS 5)
                            icon: const Icon(Icons.refresh),
                            label: const Text('Coba Lagi'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada produk tersedia.'),
                  );
                }

                final products = snapshot.data!;
                return ListView.builder(
                  itemCount: products.length,
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(product);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}