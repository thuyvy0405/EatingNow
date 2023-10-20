import 'package:fam/Widget/Big_text.dart';
import 'package:fam/Widget/app_icon.dart';
import 'package:fam/Widget/exandable.dart';
import 'package:fam/models/product_recommended_model.dart';
import 'package:fam/pages/Cart/cartPage.dart';
import 'package:fam/util/Colors.dart';
import 'package:fam/util/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../storage/cartstorage.dart';
class RecommenedFoodDetail extends StatefulWidget {
  final DataProduct dataProduct;
  const RecommenedFoodDetail({Key? key, required this.dataProduct}) : super(key: key);

  @override
  _RecommenedFoodDetailState createState() => _RecommenedFoodDetailState();
}

class _RecommenedFoodDetailState extends State<RecommenedFoodDetail> {
  int count = 0;
  double sum =0;


  void incrementCount() {
    setState(() {
      count++; // Increment the count value by 1
    });
  }
// Phương thức để thêm một món ăn vào giỏ hàng
  Future<void> _addToCart(CartItem item) async {
    // Lưu lại danh sách giỏ hàng sau khi thêm
    if(await CartStorage.addToCart(item)){
      Fluttertoast.showToast(msg: "Đã thêm vào giỏ hàng",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM_LEFT,
          backgroundColor: AppColors.toastSuccess,
          textColor: Colors.black54,
          timeInSecForIosWeb: 1,
          fontSize: 10);
      setState(() {
        count= 0;
        sum = 0;
      });
      Navigator.of(context).pop(); // Quay trở lại màn hình trước đó
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                count > 0 ?
                GestureDetector(
                    onTap: () {
                      setState(() {
                        count = 0;
                        sum = 0; // Increment the count value by 1
                      });
                    },
                  child:   AppIcon(icon: Icons.clear,
                    backgroundColor: Colors.redAccent,
                    iconColor: Colors.white,)
                  ,
                ) : SizedBox(),
                GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
                child:
                AppIcon(icon: Icons.shopping_cart_outlined
                            , backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
                // TÊN MÓN ĂN
                child: Container(
                  // Tên món ăn
                  child: Center(child: BigText(size: Dimensions.font26,text: widget.dataProduct!.foodName!),),
                  width: double.maxFinite,
                  padding:  EdgeInsets.only(top: 5, bottom:  10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )
                  ),
                ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            //hÌNH ẢNH MÓN ĂN
            flexibleSpace: FlexibleSpaceBar(
              background:
                widget.dataProduct?.uploadImage!= null?
              Image.network(widget.dataProduct?.uploadImage??"",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ):
              Image.asset(
                "assets/image/logoEN.png",
                  width: double.maxFinite,
                  fit: BoxFit.cover,),
            ),
          ),
          // PHẦN MÔ TẢ MÓN ĂN
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(text: widget.dataProduct?.description?? " "),
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                )
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20*2.5,
              right: Dimensions.width20*2.5,
              top: Dimensions.height10,
              bottom: Dimensions.height10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (count > 0) {
                      setState(() {
                        count--;
                        sum = sum - widget.dataProduct!.price!; // Increment the count value by 1
                      });
                    }
                  },
                  child: AppIcon(
                    iconsize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.remove,
                  ),
                ),
                BigText(text: NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.dataProduct?.price ?? 0)+" x "+ count.toString(), color: AppColors.mainColor,size: Dimensions.font26,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      count++;
                      sum = (widget.dataProduct!.price! * count).toDouble(); // Increment the count value by 1
                    });
                  },
                  child: AppIcon(
                    iconsize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.add,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackqroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                  )

                ),
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  child: GestureDetector(
                    onTap: () {
                      // Kiểm tra nếu count lớn hơn 0
                      if (count > 0 && widget.dataProduct != null) {
                        double price = widget.dataProduct!.price!.toDouble(); // Chuyển đổi sang double
                        CartItem newItem = CartItem(
                          name: widget.dataProduct.foodName ?? "",
                          price: price,
                          quantity: count,
                          id: widget.dataProduct.foodListId ?? 0,
                          image: widget.dataProduct.uploadImage ?? "",
                        );
                        _addToCart(newItem);
                      }
                    },
                    child: BigText(
                      text: NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(sum ?? 0) + " | Thêm vào giỏ hàng",
                      color: Colors.white,
                      size: Dimensions.font13,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: count > 0 ? AppColors.mainColor : Colors.grey, // Đặt màu xám nếu count <= 0
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
