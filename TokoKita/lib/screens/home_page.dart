import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Toko tetap di atas
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Kebutuhan Sekolah & Kantor Lengkap',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // ListView.builder untuk render daftar 20 produk secara efisien
            Expanded(
              child: ListView.builder(
                itemCount: dummyProducts.length,
                padding: const EdgeInsets.only(bottom: 16.0),
                itemBuilder: (context, index) {
                  final product = dummyProducts[index];
                  return ProductCard(product);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}