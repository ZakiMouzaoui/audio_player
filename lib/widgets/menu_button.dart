import 'package:flutter/material.dart';
import 'package:get/get.dart';



class MenuButton extends StatelessWidget {
  const MenuButton({Key? key, required this.label, required this.color, this.onTap}) : super(key: key);

  final String label;
  final Color color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final height = Get.size.height;
    final width = Get.size.width;
    final orientation = MediaQuery.of(context).orientation;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: orientation == Orientation.portrait
        ? width/3.5 : height/2,
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(label,style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}
