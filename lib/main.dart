
import 'package:fam/pages/Cart/cartPage.dart';
import 'package:fam/pages/OderFood/orderfood.dart';
import 'package:fam/pages/food/popular_food_detail.dart';
import 'package:fam/pages/food/recommened_food_detail.dart';
import 'package:fam/pages/home/getCurrentLocation_page.dart';
import 'package:fam/pages/home/main_food_page.dart';
import 'package:fam/storage/cartstorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    // Khởi tạo giỏ hàng từ SharedPreferences khi màn hình được tạo
    _loadCartItems();
  }

  // Phương thức để load danh sách món ăn từ SharedPreferences
  void _loadCartItems() async {
    List<CartItem> loadedItems = await CartStorage.getCartItems();
    setState(() {
      cartItems = loadedItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Eating Now',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/getlocation', // Mặc định
      routes: {
        '/': (context) => MainFoodPage(), // trang chính
        '/getlocation': (context) => LocationPage(link: ""), // Lấy vị trí
        '/order': (context) => OrderPage(),// Đặt hàng
        '/cartdetails': (context) => CartPage(),// Chi tiết giỏ hàng
        '/productdetail': (context) => RecommenedFoodDetail(),// Chi tiết giỏ hàng

        // Define more routes as needed
      },
    );
  }
}
