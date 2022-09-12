import 'package:audio_player/app_colors.dart';
import 'package:audio_player/controllers/detail_controller.dart';
import 'package:audio_player/controllers/popular_books_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';


class DetailPage extends StatelessWidget {
  DetailPage({Key? key}) : super(key: key);

  final popularController = Get.find<PopularBooksController>();
  final detailController = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: ()async{
          detailController.disposePlayer();
          await Future.delayed(const Duration(milliseconds: 30));
          Get.back();
          return true;
        },
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(color: loveColor)
                  ),
                  Expanded(flex:4,child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.grey[300],
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Container()),
                        const Text(
                            "Add to Playlist",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22
                          ),
                        ),
                        GetBuilder<PopularBooksController>(
                          builder: (_) =>SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                                itemCount: popularController.books.length,
                                itemBuilder: (_,index){
                                  return Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: ClipRRect(
                                      child: Image.asset(
                                        popularController.books[index]["img"],
                                        width: 90,
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(Icons.favorite, color: Colors.black,),
                              Icon(Icons.star_border),
                              Icon(Icons.remove_red_eye),
                              Icon(Icons.share)
                            ],
                          ),
                        )
                      ],
                    ),
                    )
                  )
                ],
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: ()async{
                                  detailController.disposePlayer();
                                  await Future.delayed(const Duration(milliseconds: 50));
                                  Get.back();
                                },
                                child: const Icon(Icons.arrow_back_ios,color: Colors.white,)
                            ),
                            const Icon(Icons.search, color: Colors.white,),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50,),
                      GetBuilder<DetailController>(
                        builder: (_) => Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 50,),
                              Text(
                                  Get.arguments["title"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                              ),
                              Text(
                                  Get.arguments["subtitle"],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(detailController.position.toString().split(".")[0],style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold
                                    ),),
                                    Text(detailController.duration.toString().split(".")[0],style: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold
                                    ))
                                  ],
                                ),
                              ),
                              SliderTheme(
                                  data: const SliderThemeData(
                                  ), child: Slider(
                                onChangeStart: (value){
                                  detailController.changeChanged(true);
                                },
                                onChanged: (value){
                                  detailController.changeSlider(value);
                                },
                                onChangeEnd: (value){
                                  detailController.changeChanged(false);
                                  detailController.seekToPos(value);
                                },
                                thumbColor: Colors.redAccent,
                                inactiveColor: Colors.grey[600],
                                activeColor: Colors.redAccent,
                                value: detailController.isChanging
                                    ? detailController.slider
                                    : detailController.position.inMicroseconds.toDouble(),

                                min: 0,
                                max: detailController.duration.inMicroseconds.toDouble(),
                              ),

                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                      child: Icon(
                                        Icons.loop,size: 20,
                                        color: detailController.audioPlayer.loopMode == LoopMode.one
                                        ? loveColor : null,
                                      ),
                                    onTap: (){
                                        detailController.toggleLooping();
                                    },
                                  ),
                                  GestureDetector(
                                      child: const Icon(Icons.fast_rewind),
                                      onTap: (){
                                        detailController.rewind();
                                      },
                                    onLongPress: ()async{
                                        detailController.changeRewind(true);
                                        while(detailController.isRewind){
                                          detailController.rewind();
                                          await Future.delayed(const Duration(milliseconds: 500));
                                        }
                                    },
                                    onLongPressEnd: (_){
                                      detailController.changeRewind(false);

                                    },
                                  ),
                                  InkWell(
                                    onTap: (){
                                      detailController.togglePlayer();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: loveColor
                                        ),
                                        child: detailController.audioPlayer.playing
                                      ? const Icon(Icons.pause,color: Colors.white,)
                                            : const Icon(Icons.play_arrow,color: Colors.white,)
                                    ),
                                  ),
                                  GestureDetector(
                                      child: const Icon(Icons.fast_forward),
                                    onTap: (){
                                      detailController.fastForward();
                                      detailController.changeFastForwardFactor(0);
                                    },
                                    onLongPress: ()async{
                                        detailController.changeFastForward(true);
                                      while(detailController.isFastForward){
                                        detailController.fastForward();
                                        await Future.delayed(const Duration(milliseconds: 500));
                                      }
                                    },
                                    onLongPressEnd: (_){
                                        detailController.changeFastForward(false);
                                        detailController.changeFastForwardFactor(0);
                                    },
                                  ),
                                  Image.asset(
                                      "img/loop.png",
                                    width: 15,
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 50,
                      left: Get.size.width/3,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: audioGreyBackground
                          ),
                    height: 120,
                    width: 120,
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(Get.arguments["image"]),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(color:Colors.white,width: 3)
                          ),
                        )
                  ),
                      )
                ],
              )
                ],
          )
        ),
      ),
    );
  }
}
