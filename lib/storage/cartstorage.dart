import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartStorage {
  static const String _key = 'cart_items';

  // Lấy danh sách các món ăn trong giỏ hàng từ SharedPreferences
  static Future<List<CartItem>> getCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString(_key);
    if (cartData != null) {
      final List<dynamic> decodedData = json.decode(cartData);
      final List<CartItem> cartItems = decodedData.map((data) => CartItem.fromJson(data)).toList();
      return cartItems;
    }
    return [];
  }
  // Thêm món ăn vào giỏ hàng
  static Future<bool> addToCart(CartItem newItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString(_key);
    List<CartItem> cartItems = [];
    if (cartData != null) {
      final List<dynamic> decodedData = json.decode(cartData);
      cartItems = decodedData.map((data) => CartItem.fromJson(data)).toList();
    }

    // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng hay chưa
    bool found = false;
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].id == newItem.id) {
        // Món ăn đã tồn tại, tăng số lượng
        cartItems[i].quantity += newItem.quantity;
        found = true;
        break;
      }
    }

    // Nếu món ăn chưa tồn tại, thêm nó vào giỏ hàng
    if (!found) {
      cartItems.add(newItem);
    }

    // Lưu lại danh sách giỏ hàng cập nhật
    final updatedCartData = json.encode(cartItems);
    await prefs.setString(_key, updatedCartData);
    return true;
  }
  static Future<bool> UpdateToCart(CartItem newItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString(_key);
    List<CartItem> cartItems = [];
    if (cartData != null) {
      final List<dynamic> decodedData = json.decode(cartData);
      cartItems = decodedData.map((data) => CartItem.fromJson(data)).toList();
    }

    // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng hay chưa
    bool found = false;
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].id == newItem.id) {
        // Món ăn đã tồn tại, tăng số lượng
        cartItems[i].quantity +=1;
        found = true;
        break;
      }
    }
    // Lưu lại danh sách giỏ hàng cập nhật
    final updatedCartData = json.encode(cartItems);
    await prefs.setString(_key, updatedCartData);
    return true;
  }
  static Future<bool> RemoveToCart(CartItem newItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString(_key);
    List<CartItem> cartItems = [];
    if (cartData != null) {
      final List<dynamic> decodedData = json.decode(cartData);
      cartItems = decodedData.map((data) => CartItem.fromJson(data)).toList();
    }
    if(newItem.quantity == 1){
      cartItems.removeWhere((item) => item.id == newItem.id); // Xóa món ăn dựa trên ID
    }
    else{
      // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng hay chưa
      for (int i = 0; i < cartItems.length; i++) {
        if (cartItems[i].id == newItem.id) {
          // Món ăn đã tồn tại, tăng số lượng
          cartItems[i].quantity-=1;
          break;
        }
      }
    }
    // Lưu lại danh sách giỏ hàng cập nhật
    final updatedCartData = json.encode(cartItems);
    await prefs.setString(_key, updatedCartData);
    return false;
  }

  static Future<bool> RemoveItemToCart(CartItem newItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString(_key);
    List<CartItem> cartItems = [];

    if (cartData != null) {
      final List<dynamic> decodedData = json.decode(cartData);
      cartItems = decodedData.map((data) => CartItem.fromJson(data)).toList();
    }

    cartItems.removeWhere((item) => item.id == newItem.id); // Xóa món ăn dựa trên ID

    // Lưu lại danh sách giỏ hàng cập nhật
    final updatedCartData = json.encode(cartItems);
    await prefs.setString(_key, updatedCartData);

    return false;
  }



}

class CartItem {
  final int id;
  final String name;
  final double price;
  int quantity;
  final String image;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });

  // Chuyển đổi dữ liệu CartItem thành một Map
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'quantity': quantity,
    'image': image
  };

  // Tạo một đối tượng CartItem từ Map
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      image: json['image'],
    );
  }
}
