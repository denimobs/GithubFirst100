import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomToast extends StatelessWidget {
  final String title;
  final String message;
  final Widget icon;
  final Color color;

  CustomToast({
    @required this.title,
    @required this.color,
    @required this.icon,
    @required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      width: Get.width * 0.9,
      margin: EdgeInsets.all(8),
      child: Material(
        elevation: 4,
        color: Colors.white,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(5),
        child: Center(
          child: Row(
            children: [
              _buildIcon(),
              SizedBox(width: 10),
              Expanded(child: _buildBody()),
              SizedBox(width: 10),
              Container(
                color: color,
                width: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        color: color,
        child: IconTheme(
          data: IconThemeData(
            color: Colors.white,
            size: 36,
          ),
          child: icon,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.subtitle2.copyWith(color: color),
          ),
          Text(
            message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.bodyText2.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
