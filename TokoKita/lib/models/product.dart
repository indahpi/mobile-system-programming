class Product {
  int id;
  String name;
  double price;
  String category;
  int stock;
  String? description; // Nullable (Langkah 5)
  String? imageUrl; // Nullable

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.stock,
    this.description,
    this.imageUrl,
  });

  String getInfo() => "[$id] $name - Rp ${price.toStringAsFixed(0)} (Stok: $stock)";

  // Method factory untuk parsing JSON dari API (Langkah 3)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      name: json['title'] ?? '', // Fake Store API menggunakan key 'title'
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] ?? 0.0),
      category: json['category'] ?? '',
      stock: 10, // Default stock karena API tidak menyediakan field stock
      description: json['description'] ?? '',
      imageUrl: json['image'] ?? '', // Fake Store API menggunakan key 'image'
    );
  }

  // Tugas mandiri 1
  String getStatusStok() {
    if (stock > 5) return 'Tersedia';
    if (stock > 0) return 'Stok Terbatas';
    return 'Habis';
  }
}

// Inheritance (Langkah 5)
class DiscountedProduct extends Product {
  double discountPercent;
  DiscountedProduct({
    required super.id,
    required super.name,
    required super.price,
    required super.imageUrl,
    required super.category,
    required super.stock,
    super.description,
    required this.discountPercent,
  });

  double hitungHargaFinal() => price - (price * (discountPercent / 100));
}

// Fungsi hitungHargaDiskonBiasa (Langkah 4)
double hitungHargaDiskonBiasa(double harga, double persenDiskon) => harga - (harga * (persenDiskon / 100));
double hitungHargaSetelahDiskon({required double harga, double persenDiskon = 0.0}) => harga - (harga * (persenDiskon / 100));
String formatRupiah(double nominal) => "Rp ${nominal.toStringAsFixed(0)}";

// Fungsi hitungTotalBelanja (Tugas mandiri 3)
double hitungTotalBelanja(List<Product> keranjang) {
  double total = 0;
  for (var p in keranjang) {
    total += p.price;
  }
  return total;
}

// Data Dummy 20 Produk Peralatan Sekolah (Lengkap utuh punya kamu)
List<Product> dummyProducts = [
  Product(id: 1, name: "Buku Tulis Sidu 38 Lembar", price: 5000, category: "Buku & Kertas", stock: 25, description: "Buku tulis dengan kertas berkualitas tebal 38 lembar"),
  DiscountedProduct(id: 2, name: "Pensil 2B Faber Castell", price: 4000, imageUrl: null, category: "Alat Tulis", stock: 4, description: "Pensil ujian kualitas unggul dengan tingkat kegelapan 2B yang teruji", discountPercent: 10.0,),
  Product(id: 3, name: "Penggaris Plastik 30cm", price: 3000, category: "Alat Tulis", stock: 0, description: "Penggaris bening transparan ukuran 30cm yang tidak mudah patah."),
  Product(id: 4, name: "Penghapus Joyko B40", price: 2000, category: "Alat Tulis", stock: 15, description: "Penghapus lembut yang dapat membersihkan bekas pensil tanpa merusak kertas."),
  Product(id: 5, name: "Tipe-X Correction Tape", price: 8000, category: "Alat Tulis", stock: 10, description: "Tipe-X Correction Tape praktis yang langsung kering"),
  Product(id: 6, name: "Tas Sekolah BackPack", price: 120000, category: "Perlengkapan", stock: 3, description: "Tas sekolah anti air dengan banyak kompartemen"),
  DiscountedProduct(id: 7, name: "Kotak Pensil Kaleng", price: 25000, imageUrl: null, category: "Perlengkapan", stock: 8, description: "Kotak pensil berbahan kaleng kokoh", discountPercent: 10.0,),
  Product(id: 8, name: "Set Drawing Pen 0.5", price: 15000, category: "Alat Tulis", stock: 6, description: "Satu set pensil menggambar dengan ketebalan 0.5mm"),
  DiscountedProduct(id: 9, name: "Spidol Boardmarker Snowman", price: 9000, imageUrl: null, category: "Alat Tulis", stock: 20, description: "Spidol papan tulis yang dapat dihapus", discountPercent: 10.0,),
  Product(id: 10, name: "Sticky Notes Warna-Warni", price: 6000, category: "Buku & Kertas", stock: 12, description: "Kertas catatan warna-warni berukuran sedang"),
  Product(id: 11, name: "Map Plastik", price: 4500, category: "Perlengkapan", stock: 30, description: "Map plastik untuk berkas ukuran F4 (bisa digunakan untuk ukuran A4)."),
  DiscountedProduct(id: 12, name: "Stapler Medium Joyko", price: 18000, imageUrl: null, category: "Alat Tulis", stock: 5, description: "Stapler ukuran sedang", discountPercent: 10.0,),
  Product(id: 13, name: "Isi Stapler No. 10", price: 2500, category: "Alat Tulis", stock: 40, description: "Isi stapler ukuran sedang"),
  Product(id: 14, name: "Gunting Kertas Stainless", price: 12000, category: "Alat Tulis", stock: 9, description: "Gunting kertas stainless steel tajam dan tahan karat"),
  DiscountedProduct(id: 15, name: "Binder A5 Kulit Sintetis", price: 45000, imageUrl: null, category: "Buku & Kertas", stock: 7, description: "Binder ukuran A5 berbahan kulit sintetis", discountPercent: 10.0,),
  Product(id: 16, name: "Isi Binder A5 50 Lembar", price: 8500, category: "Buku & Kertas", stock: 18, description:"Isi ulang binder A5 garis berisi 50 lembar"),
  Product(id: 17, name: "Highlighter Kenko Set 4 Warna", price: 16000, category: "Alat Tulis", stock: 11, description:"Satu set Highlighter merk Kenko 4 warna"),
  DiscountedProduct(id: 18, name: "Kalkulator Scientific Casio", price: 150000, imageUrl: null, category: "Elektronik", stock: 4, description: "Kalkulator ilmiah dengan fitur lengkap", discountPercent: 10.0,),
  Product(id: 19, name: "Paper Clip Warna Box", price: 5000, category: "Alat Tulis", stock: 22, description: "Klip kertas plastik warna-warni isi 1 box (10 pcs)"),
  Product(id: 20, name: "Double Tape 1 Inchi", price: 7000, category: "Alat Tulis", stock: 14, description: "Double Tape berukuran 1 inci"),
];