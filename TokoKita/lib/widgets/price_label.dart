import 'package:flutter/material.dart';
import '../models/product.dart'; // Mengambil fungsi formatRupiah

class PriceLabel extends StatelessWidget {
  final double price;

  const PriceLabel({
    super.key,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      formatRupiah(price),
      style: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }
}