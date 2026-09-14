// Class & fungsi
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
  for (var p in keranjang) total += p.price;
  return total;
}

// Data Dummy 8 Produk Peralatan Sekolah (Tugas mandiri 2)
List<Product> dummyProducts = [
  Product(id: 1, name: "Buku Tulis Sidu 38 Lembar", price: 5000, category: "Buku & Kertas", stock: 25, description: "Buku garis tebal"),
  Product(id: 2, name: "Pensil 2B Faber Castell", price: 4000, category: "Alat Tulis", stock: 4, description: "Pensil ujian"),
  Product(id: 3, name: "Penggaris Plastik 30cm", price: 3000, category: "Alat Tulis", stock: 0),
  Product(id: 4, name: "Penghapus Joyko B40", price: 2000, category: "Alat Tulis", stock: 15),
  Product(id: 5, name: "Tipe-X Correction Tape", price: 8000, category: "Alat Tulis", stock: 10),
  Product(id: 6, name: "Tas Sekolah BackPack", price: 120000, category: "Perlengkapan", stock: 3, description: "Tas anti air"),
  Product(id: 7, name: "Kotak Pensil Kaleng", price: 25000, category: "Perlengkapan", stock: 8),
  Product(id: 8, name: "Set Drawing Pen 0.5", price: 15000, category: "Alat Tulis", stock: 6),
];

// Fungsi main
void main() {

  // Langkah 1 : Variabel & tipe data
  const String namaToko = "TokoKita Indah";
  final String tanggalMasuk = "15 September 2026";
  var namaKasir = "Siti";
  namaKasir = "Ahmad";
  int stokBuku = 50;
  double hargaBuku = 5000.0;
  String namaProdukUtama = "Buku Tulis Sidu";
  bool isTersedia = true;
  List<String> daftarKategori = ['Alat Tulis', 'Buku & Kertas', 'Perlengkapan'];
  Map<String, dynamic> dataMentah = {'id': 'SCH-001', 'nama': namaProdukUtama, 'harga': hargaBuku, 'stok': stokBuku, 'is_available': isTersedia, 'kategori': daftarKategori[1]};

  print("--- LANGKAH 1: VARIABEL & TIPE DATA ---");
  print("Toko: $namaToko | Kasir: $namaKasir ($tanggalMasuk)");
  print("Produk: $namaProdukUtama | Harga: Rp $hargaBuku | Stok: $stokBuku | Available: $isTersedia");
  print("Kategori: $daftarKategori");
  print("Data Mentah: $dataMentah\n");


  // Langkah 2: Operator perhitungan harga
  int jumlahBeli = 5;
  double totalAwal = hargaBuku * jumlahBeli;
  int sisaStok = stokBuku - jumlahBeli;
  bool apakahMahal = hargaBuku > 10000;
  bool apakahStokCukup = sisaStok >= 0;
  bool layakTampilkan = (sisaStok > 0) && (hargaBuku > 0);

  print("--- LANGKAH 2: OPERATOR PERHITUNGAN HARGA ---");
  print("Total Beli ($jumlahBeli item): Rp $totalAwal | Sisa Stok: $sisaStok");
  print("Harga > 10k: $apakahMahal | Stok Cukup: $apakahStokCukup | Layak Tampil: $layakTampilkan\n");


  // Langkah 3: Control flow
  String statusStokText = (stokBuku > 5) ? 'Tersedia' : ((stokBuku > 0) ? 'Stok Terbatas' : 'Habis');
  List<double> daftarHargaBelanja = [5000.0, 4000.0, 15000.0];
  double totalBelanjaLoop = 0;
  for (var h in daftarHargaBelanja) totalBelanjaLoop += h;

  print("--- LANGKAH 3: CONTROL FLOW ---");
  print("1. Status Stok Buku: $statusStokText");
  print("2. Total Loop Belanja: Rp $totalBelanjaLoop");
  print("3. Simulasi Penjualan Pensil (While Loop):");
  int simulasiStok = 3;
  while (simulasiStok > 0) {
    simulasiStok--;
    print("   - Terjual 1, sisa stok: $simulasiStok");
  }
  String katProduk = 'Alat Tulis';
  double diskonKat = (katProduk == 'Alat Tulis') ? 10.0 : 0.0;
  print("4. Diskon Kategori '$katProduk': $diskonKat%\n");


  // Langkah 4: fungsi logika produk & diskon
  double hrgAwal = 120000.0;
  print("--- LANGKAH 4: FUNCTION LOGIKA PRODUK & DISKON ---");
  print("Harga Awal Tas: ${formatRupiah(hrgAwal)}");
  print("Diskon Biasa (10%): ${formatRupiah(hitungHargaDiskonBiasa(hrgAwal, 10))}");
  print("Diskon Named Param (15%): ${formatRupiah(hitungHargaSetelahDiskon(harga: hrgAwal, persenDiskon: 15))}\n");


  // Langkah 5: class product, inheritance & null safety
  Product p1 = Product(id: 101, name: "Seragam SMA", price: 85000, imageUrl: "SeragamSMA.jpg",
      category: "Perlengkapan", stock: 12, description: "Bahan katun");
  DiscountedProduct p2 = DiscountedProduct(id: 102, name: "Set Crayon 24 Warna", price: 45000,
      imageUrl: "Crayon24.jpg", category: "Alat Tulis", stock: 5, discountPercent: 20);

  print("--- LANGKAH 5: CLASS, INHERITANCE & NULL SAFETY ---");
  print("Product 1: ${p1.getInfo()} | Deskripsi: ${p1.description ?? 'Tidak Ada'}");
  print("Product 2: ${p2.getInfo()} | Harga Diskon: ${formatRupiah(p2.hitungHargaFinal())}\n");


  // Tugas mandiri 1: method getStatusStok()
  print("--- TUGAS MANDIRI 1: METHOD getStatusStok() ---");
  print("${dummyProducts[0].name} (Stok 25) -> Status: ${dummyProducts[0].getStatusStok()}");
  print("${dummyProducts[1].name} (Stok 4)  -> Status: ${dummyProducts[1].getStatusStok()}");
  print("${dummyProducts[2].name} (Stok 0)  -> Status: ${dummyProducts[2].getStatusStok()}\n");


  // Tugas mandiri 2: List 8 dummy product
  print("--- TUGAS MANDIRI 2: LIST 8 DUMMY PRODUK ---");
  for (int i = 0; i < dummyProducts.length; i++) {
    print("${i + 1}. ${dummyProducts[i].getInfo()} | Status: ${dummyProducts[i].getStatusStok()}");
  }
  print("");


  // Tugas mandiri 3: fungsi hitungTotalBelanja()
  List<Product> keranjang = [dummyProducts[0], dummyProducts[1], dummyProducts[5]];
  print("--- TUGAS MANDIRI 3: FUNCTION hitungTotalBelanja() ---");
  print("Daftar Belanja: ${keranjang.map((e) => e.name).join(', ')}");
  print("Total Belanja Keseluruhan: ${formatRupiah(hitungTotalBelanja(keranjang))}");
}