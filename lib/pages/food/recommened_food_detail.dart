import 'package:fam/Widget/Big_text.dart';
import 'package:fam/Widget/app_icon.dart';
import 'package:fam/Widget/exandable.dart';
import 'package:fam/util/Colors.dart';
import 'package:fam/util/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecommenedFoodDetail extends StatelessWidget {
  const RecommenedFoodDetail({Key?key}): super(key: key);

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
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
                child: Container(

                  child: Center(child: BigText(size: Dimensions.font26,text: "VietNamese Side"),),
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
            flexibleSpace: FlexibleSpaceBar(
              background:Image.asset(
                "assets/image/food0.png",
                  width: double.maxFinite,
                  fit: BoxFit.cover,

              ),

            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(text: "chicken master chng tới Việt Nam thăm cấp nhà nước theo lời mời của Tổng Bí thư Nguyễn Phú Trọng.Tổng thống Mỹ Joe Bidenchicken master chng tới Việt Nam thăm cấp nhà nước theo lời mời của Tổng Bí thư Nguyễn Phú Trọng.Tổng thống Mỹ Joe Bidenchicken master chng tới Việt Nam thăm cấp nhà nước theo lời mời của Tổng Bí thư Nguyễn Phú Trọng.Tổng thống Mỹ Joe Bidenchicken master chng tới Việt Nam thăm cấp nhà nước theo lời mời của Tổng Bí thư Nguyễn Phú Trọng.Tổng thống Mỹ Joe Bidenchicken master chng tới Việt Nam thăm cấp nhà nước theo lời mời của Tổng Bí thư Nguyễn Phú Trọng.Tổng thống Mỹ Joe Biden"),
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
                AppIcon(
                    iconsize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.remove),
                BigText(text: "\$12.88 "+" X "+" 0 ", color: AppColors.mainBackColor,size: Dimensions.font26,),
                AppIcon(
                    iconsize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.add),
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
                  child: Row(
                    children: [
                      Icon(Icons.remove, color: AppColors.signColor,),
                      SizedBox(width: Dimensions.width10/2,),
                      BigText(text: "0"),
                      SizedBox(width: Dimensions.width10/2,),
                      Icon(Icons.add, color: AppColors.signColor,),
                    ],
                  ),

                ),
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),

                  child: BigText(text: "\$10 | Add to cart", color: Colors.white,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
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
