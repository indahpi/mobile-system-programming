import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/cart_controller.dart'; // <-- 1. IMPORT CONTROLLER-NYA DI SINI
import 'screens/main_page.dart';
import 'screens/product_detail_page.dart';
import 'screens/login_page.dart';

void main() {
  // 2. INISIALISASI CONTROLLER SECARA GLOBAL SEBELUM APLIKASI DIJALANKAN
  Get.put(CartController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TokoKita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/detail': (context) => const ProductDetailPage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}