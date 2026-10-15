import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../controllers/cart_controller.dart';
import '../services/product_service.dart'; // <-- 1. Diimport untuk akses fetchProductDetail

class ProductDetailPage extends StatefulWidget {
  final Product? product;
  final int? productId; // <-- 2. Tambahan parameter opsional ID untuk alternatif fetch API

  const ProductDetailPage({super.key, this.product, this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;
  final ProductService _productService = ProductService(); // Instance service API

  void _increment(int maxStock) {
    if (_quantity < maxStock) {
      setState(() {
        _quantity++;
      });
    }
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Jika objek produk dikirim langsung via navigasi, gunakan langsung
    if (widget.product != null) {
      return _buildProductView(context, widget.product!);
    }

    // Jika hanya productId yang dikirim, gunakan FutureBuilder untuk fetch data dari API (Tugas Mandiri 1)
    if (widget.productId != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Produk'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ),
        body: FutureBuilder<Product>(
          future: _productService.fetchProductDetail(widget.productId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Gagal memuat detail produk:\n${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('Data produk tidak ditemukan.'));
            }

            return _buildProductView(context, snapshot.data!);
          },
        ),
      );
    }

    // Fallback jika keduanya null
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: const Center(child: Text('Data produk tidak ditemukan.')),
    );
  }

  // Method helper untuk merender UI detail produk (agar bersih dan bisa dipakai ulang)
  Widget _buildProductView(BuildContext context, Product currentProduct) {
    final CartController cartController = Get.find();

    final DiscountedProduct? discountedProduct =
    currentProduct is DiscountedProduct ? currentProduct : null;
    final bool isDiscounted = discountedProduct != null;

    final double finalPrice = discountedProduct != null
        ? discountedProduct.hitungHargaFinal()
        : currentProduct.price;

    final double totalPrice = finalPrice * _quantity;

    return Scaffold(
      appBar: widget.product != null
          ? AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      )
          : null, // AppBar sudah dihandle di FutureBuilder jika via ID
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.grey[200],
              child: Image.network(
                currentProduct.imageUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.school, size: 80, color: Colors.grey);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge Stok & Diskon
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: currentProduct.stock == 0
                              ? Colors.red
                              : (currentProduct.stock <= 5
                              ? Colors.orange
                              : Colors.green),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          currentProduct.stock == 0
                              ? 'Stok Habis'
                              : 'Stok: ${currentProduct.stock}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (isDiscounted) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Diskon ${discountedProduct.discountPercent.toStringAsFixed(0)}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Nama Produk
                  Text(
                    currentProduct.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Harga Produk
                  if (isDiscounted) ...[
                    Row(
                      children: [
                        Text(
                          'Rp ${finalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Rp ${currentProduct.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Text(
                      'Rp ${currentProduct.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),

                  // Deskripsi
                  const Text(
                    'Deskripsi Produk',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    (currentProduct.description != null &&
                        currentProduct.description!.isNotEmpty)
                        ? currentProduct.description!
                        : 'Belum ada deskripsi untuk produk ini.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),

                  // Pengatur Jumlah Pembelian
                  const Text(
                    'Jumlah Pembelian',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tombol Tambah/Kurang
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: _quantity > 1 ? _decrement : null,
                              color: Colors.blue,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                '$_quantity',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: _quantity < currentProduct.stock
                                  ? () => _increment(currentProduct.stock)
                                  : null,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                      // Total Harga Dinamis
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Total Harga:',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            'Rp ${totalPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Tombol Tambah ke Keranjang
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor:
            currentProduct.stock == 0 ? Colors.grey : Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(Icons.shopping_cart),
          label: const Text(
            'Tambah ke Keranjang',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onPressed: currentProduct.stock == 0
              ? null
              : () {
            cartController.addToCart(currentProduct, quantity: _quantity);
            Get.snackbar(
              'Berhasil!',
              '$_quantity ${currentProduct.name} ditambahkan ke keranjang',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.blueGrey,
              colorText: Colors.white,
              borderRadius: 10,
              margin: const EdgeInsets.all(12),
              duration: const Duration(seconds: 2),
              isDismissible: true,
              icon: const Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}