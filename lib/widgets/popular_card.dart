import 'package:audio_player/controllers/detail_controller.dart';
import 'package:audio_player/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_colors.dart';


class PopularCardWidget extends StatelessWidget {
  PopularCardWidget({Key? key, required this.rating, required this.image, required this.title, required this.subTitle, required this.url}) : super(key: key);

  final String rating;
  final String image;
  final String title;
  final String subTitle;
  final String url;

  final detailController = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: ()async{
          detailController.playAudio(url);
          await Future.delayed(const Duration(milliseconds: 40));
          Get.to(
                  ()=>DetailPage(),
              arguments: {
                "title": title,
                "subtitle": subTitle,
                "image": image,
                "url": url
              }
          );
        },
        child: Container(
          height: 120,
          margin: const EdgeInsets.only(top:10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(4,4),
                    color: Colors.grey[100]!,
                    blurRadius: 15
                )
              ]
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                child: Image.asset(image),
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star,color: starColor,),
                      Text(rating,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red[400]
                      ),)
                    ],
                  ),
                  Text(title,style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  ),
                  ),
                  const SizedBox(height: 3,),
                  Text(subTitle,
                    style: const TextStyle(
                        color: subTitleText,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                    decoration: BoxDecoration(
                        color: loveColor,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Center(
                      child: Text("Love",
                        style: TextStyle(
                            color: Colors.white
                        ),),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
