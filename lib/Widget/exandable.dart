//import 'dart:html';

import 'package:fam/Widget/Small_text.dart';
import 'package:fam/util/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/dimensions.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key?key, required this.text}): super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  String text  = "Show more";
  double textHeight = Dimensions.screenHeight/5.63;

  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHeight)
      {
        firstHalf= widget.text.substring(0, textHeight.toInt());
        secondHalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
      }else
        {
          firstHalf = widget.text;
          secondHalf = "";
        }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(color: AppColors.paraColor,size: Dimensions.font16,text: firstHalf):Column(
        children: [
          SmallText(heigh: 1.8,color: AppColors.paraColor,size: Dimensions.font16,text: hiddenText?(firstHalf+"..."):(firstHalf+secondHalf)),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
                (text == "Show more") ? text = "Hide less" :text = "Show more";
              });
            },
            child: Row(
              children: [
                SmallText(text: text, color: AppColors.mainColor,),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up, color: AppColors.mainColor,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
