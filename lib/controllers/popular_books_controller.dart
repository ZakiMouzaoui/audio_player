import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PopularBooksController extends GetxController{
  var populars = [];
  var books = [];

  @override
  void onReady() {
    super.onReady();
    getPopulars();
    getBooks();
  }

  void getPopulars()async{
    final jsonData = await rootBundle.loadString("json/popular_books.json");
    populars = jsonDecode(jsonData);
    update();
  }

  void getBooks()async{
    final jsonData = await rootBundle.loadString("json/books.json");
    books = jsonDecode(jsonData);
    update();
  }

  void getPopularBooks(){
    books = [];
    update();
  }
}