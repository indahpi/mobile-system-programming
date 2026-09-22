import 'package:flutter/material.dart';

class StockBadge extends StatelessWidget {
  final String status; // Berisi 'Tersedia', 'Stok Terbatas', atau 'Habis'

  const StockBadge({
    super.key,
    required this.status,
  });

  // Menentukan warna badge berdasarkan teks status
  Color _getBadgeColor() {
    switch (status) {
      case 'Tersedia':
        return Colors.green;
      case 'Stok Terbatas':
        return Colors.orange;
      case 'Habis':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getBadgeColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}