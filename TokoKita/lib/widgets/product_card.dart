import 'package:flutter/material.dart';
import '../models/product.dart';
import 'price_label.dart'; // Import custom widget PriceLabel
import 'stock_badge.dart'; // Import custom widget StockBadge
import 'category_tag.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    print('LOG: initState() dipanggil untuk -> ${widget.product.name}');
  }

  @override
  void dispose() {
    print('LOG: dispose() dipanggil untuk -> ${widget.product.name}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('LOG: build() dipanggil untuk -> ${widget.product.name} (isFavorite: $isFavorite)');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Icon / Placeholder
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.shopping_bag,
                size: 40,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(width: 12),

            // Nama, Harga (PriceLabel), dan Status Stok (StockBadge)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoryTag(category: widget.product.category),
                  const SizedBox(height: 4),
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Menggunakan PriceLabel
                  PriceLabel(price: widget.product.price),

                  const SizedBox(height: 6),

                  // Menggunakan StockBadge dengan nilai dari method getStatusStok()
                  StockBadge(status: widget.product.getStatusStok()),
                ],
              ),
            ),

            // Tombol Favorit (Love)
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}