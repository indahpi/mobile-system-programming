import 'package:get/get.dart';
import '../models/product.dart';

// Model pendukung untuk mencatat produk beserta jumlah (quantity)-nya
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartController extends GetxController {
  // List reaktif menampung CartItem
  var cartItems = <CartItem>[].obs;

  // Menambah produk ke keranjang (mendukung quantity sekaligus)
  void addToCart(Product product, {int quantity = 1}) {
    final index = cartItems.indexWhere((item) => item.product.name == product.name);
    if (index >= 0) {
      cartItems[index].quantity += quantity;
      cartItems.refresh(); // Memicu update reaktif Obx
    } else {
      cartItems.add(CartItem(product: product, quantity: quantity));
    }
  }

  // Menambah quantity item di keranjang
  void incrementQuantity(CartItem item) {
    item.quantity++;
    cartItems.refresh();
  }

  // Mengurangi quantity (jika sisa 1 dan dikurangi, maka item dihapus)
  void decrementQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      cartItems.refresh();
    } else {
      removeFromCart(item);
    }
  }

  // Menghapus item dari keranjang
  void removeFromCart(CartItem item) {
    cartItems.remove(item);
  }

  // Getter total item keseluruhan
  int get totalItem => cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Getter total harga otomatis (mengalikan harga final/diskon dengan quantity masing-masing)
  double get totalHarga {
    double total = 0;
    for (var item in cartItems) {
      double price = item.product is DiscountedProduct
          ? (item.product as DiscountedProduct).hitungHargaFinal()
          : item.product.price;
      total += price * item.quantity;
    }
    return total;
  }

  // Method untuk mengosongkan seluruh isi keranjang
  void clearCart() {
    cartItems.clear();
  }
}