import 'package:fam/Widget/Big_text.dart';
import 'package:fam/Widget/Small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../storage/cartstorage.dart';
import '../../util/Colors.dart';
import '../../util/dimensions.dart';
import '../food/recommened_food_detail.dart';
import '../home/getCurrentLocation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';



class OrderPage extends StatefulWidget {

  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPage createState() => _OrderPage();
}
class _OrderPage extends State<OrderPage> {
  String addressdelivery = '';
  String nameAddressdelivery ='';
  late  SharedPreferences prefs;
  List<CartItem> cartItem = [];
  void _loadCartItems() async {
    List<CartItem> loadedItems = await CartStorage.getCartItems();
    setState(() {
      cartItem = loadedItems;
    });
  }
  late bool result;

  @override
  initState() {
    super.initState();
    getAddressDelivery();
    setState(() {
      result = false;
    });
    _loadCartItems();
  }
  void getAddressDelivery() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      addressdelivery = prefs.getString('address') ?? '';
      nameAddressdelivery =prefs.getString('name') ?? '';
    });
  }
// Method to reload content
  void reloadContent() {
    _loadCartItems();
    setState(() {
      // Reload your content, update variables, etc.
      result = false; // Reset result to false if needed
    });
  }


  @override
  Widget build(BuildContext context) {
    //final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  //  final cartItem = arguments['data']; // Access 'your_data' here
    double totalAmount = cartItem.fold(0, (total, item) => total + (item.price * item.qty));
    if (result) {
      reloadContent(); // Automatically call reloadContent when result is true
    }
    return Scaffold(
      appBar: AppBar(
        title: Column(

          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          BigText(text:'Chi tiết đơn hàng',size: Dimensions.font26,),
          SmallText(text: 'Khoảng cách tới vị trí bạn: 1km',color: Colors.black,size: Dimensions.font13,)
        ],),
        centerTitle: true, // Để căn giữa tiêu đề trên thanh AppBar
        // Các thuộc tính khác của AppBar
        backgroundColor: AppColors.mainColor, // Màu nền cho AppBar
     ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           Column(
             mainAxisAlignment: MainAxisAlignment.center, // Đảm bảo dòng text ở giữa
             children: [
               Row(
                 children: [
                   Icon(
                     Icons.error,
                     color: Colors.redAccent, // Màu sắc của biểu tượng "!"
                   ),
                   Text(
                     'Kiểm tra lại thông tin vị trí nhận hàng',
                     style: TextStyle(fontSize: Dimensions.font16, fontStyle: FontStyle.italic,),
                   ),
                 ],
               ),
               Row(
                 children: [
                   Icon(
                     Icons.location_on,
                     color: Colors.green,
                     // Màu sắc của biểu tượng vị trí
                   ),
                   GestureDetector(
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => LocationPage(link: "/order")), // truyền vào link cần trở lại khi đã chọn được vị trí
                       );
                     },
                     child: Row(
                       children: [
                         Container(
                           height: Dimensions.height45,
                           width: Dimensions.screenWidth - 110,
                           child:
                           BigText(text: addressdelivery, size: Dimensions.font13,),
                         ),
                         Icon(Icons.arrow_drop_down_rounded)
                       ],
                     ),
                   )

                 ],
               )

             ],
           ),
            Text(
              'Sản phẩm trong đơn hàng:',
              style: TextStyle(fontSize: Dimensions.font16,
                fontWeight: FontWeight.bold,
                 ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height:10),
            for (var item in cartItem)

              Card(
                margin: EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: Image.network(
                    item.uploadImage ?? "",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item.foodName + ' x ${item.qty}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      BigText(text: NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(item.price * item.qty ?? 0), color: AppColors.mainColor,size: Dimensions.font13,),
                      GestureDetector(
                        onTap: () async {
                          final kq = await Navigator.pushNamed(
                            context,
                            "/productdetail",
                            arguments: {'data': item},
                          );

                          if (kq != null && kq is bool) {
                            setState(() {
                              result = kq;
                            });
                          }
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.edit,
                              color: Colors.blueAccent,
                              size: 15,
                            ),
                            Text('Chỉnh sửa', style: TextStyle(color: Colors.blueAccent)),
                          ],
                        ),
                      ),                    ],
                  ),
                ),
              ),
            Card(
              margin: EdgeInsets.only(bottom: 16),
              child: ListTile(
                title: Text(
                  'Tổng cộng: \$${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Thực hiện đặt đơn hàng và xử lý dữ liệu
                // Ở đây, bạn có thể gửi dữ liệu đặt hàng đến máy chủ hoặc xử lý nó theo nhu cầu của bạn.
              },
              child: Text('Đặt đơn'),
            ),
          ],
        ),
      ),
    );
  }


}
