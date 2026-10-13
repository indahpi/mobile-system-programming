import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../controllers/cart_controller.dart';
import 'cart_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Biru
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
                    // Badge Keranjang Reaktif Obx
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
                        // Tampilkan badge merah jika totalItem > 0
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
                    // Tombol Login aslimu
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

          // ListView daftar produk
          Expanded(
            child: ListView.builder(
              itemCount: dummyProducts.length,
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
              itemBuilder: (context, index) {
                final product = dummyProducts[index];
                return ProductCard(product);
              },
            ),
          ),
        ],
      ),
    );
  }
}