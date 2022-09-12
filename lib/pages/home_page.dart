import 'package:audio_player/app_colors.dart';
import 'package:audio_player/controllers/popular_books_controller.dart';
import 'package:audio_player/widgets/menu_button.dart';
import 'package:audio_player/widgets/popular_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);


  final popularController = Get.put(PopularBooksController());

  @override
  Widget build(BuildContext context) {
    final height = Get.size.height; // 684
    final width = Get.size.width; // 411
    final orientation = MediaQuery.of(context).orientation;
    final pageViewCtrl = PageController(
        viewportFraction: orientation == Orientation.portrait ? 0.85 : 0.5
    );

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<PopularBooksController>(
          builder: (_) => Container(
            padding: EdgeInsets.symmetric(vertical: orientation == Orientation.portrait
                ? height/68.4 : width/68.4),
            color: background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // APP BAR
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: orientation == Orientation.portrait
                              ? width/20.5 : height/20.5),
                          child: Row(
                            children: [
                              Image.asset(
                                "img/menu.png",
                                width: orientation == Orientation.portrait
                                    ? width/27.4 : height/27.4,
                              ),
                              Expanded(child: Container()),
                              Icon(Icons.search, size: orientation == Orientation.portrait
                                  ? width/20.5 : height/20.5,),
                              SizedBox(width: width/41.1,),
                              Icon(Icons.notifications_active, size: orientation == Orientation.portrait
                                  ? width/20.5 : height/20.5,)
                            ],
                          ),
                        ),
                        SizedBox(height: orientation == Orientation.portrait
                            ? height/68.4 : width/68.4,),

                        // POPULAR BOOKS
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: orientation == Orientation.portrait
                              ? width/20.5 : height/20.5),
                          child: Text("Popular Books",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: orientation == Orientation.portrait
                                  ? width/20.5 : height/20.5
                          ),
                          ),
                        ),
                        SizedBox(height: orientation == Orientation.portrait
                            ? height/68.4 : width/68.4,),
                        // POPULAR PAGE VIEW
                        SizedBox(
                          height: orientation == Orientation.portrait
                              ? height/3.8 : width/3.8,
                          child: Stack(
                            children: [
                              Positioned(
                                top:0,
                                bottom: 0,
                                right: 0,
                                left: orientation == Orientation.portrait
                                    ? width/-41.1 : -height/2.05,
                                child: SizedBox(
                                  height: orientation == Orientation.portrait
                                      ? height/3.8 : width/3.8,
                                  child: PageView.builder(
                                      controller: pageViewCtrl,
                                      itemCount: popularController.populars.length,
                                      itemBuilder: (_,index) => Container(
                                        margin: index != 3 ? EdgeInsets.only(
                                            right: orientation == Orientation.portrait
                                                ? width/41.1 : height/41.1
                                        ) : null,
                                        child: ClipRRect(
                                          child: Image.asset(
                                            popularController.populars[index]["img"],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: orientation == Orientation.portrait
                            ? height/22.8 : width/22.8,),

                        // MENU BUTTON

                        //const SizedBox(height: 10,),
                      ],
                    ),
                  flex: 1,
                ),


                // BOOKS LIST VIEW
                Expanded(
                  flex: 1,
                  child: popularController.books.isEmpty ? const Center(child: Text("No Books Found"),) : ListView.builder(
                      itemCount: popularController.books.length,
                      itemBuilder: (_,index) => PopularCardWidget(
                          rating: popularController.books[index]["rating"],
                          image: popularController.books[index]["img"],
                          title: popularController.books[index]["title"],
                          subTitle: popularController.books[index]["text"],
                          url: popularController.books[index]["audio"],
                      )
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}
