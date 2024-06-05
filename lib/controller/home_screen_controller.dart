import 'dart:convert';
import 'dart:developer';

import 'package:final_exam_news/model/news_api_resmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  bool isLoading = false;
  NewsApiResModel? newsApiResModel;

  Future getData() async {
    isLoading = true;
    notifyListeners();

    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=220fa64cb6a04208b4e9a71e73817f3a");

    var res = await http.get(url);

    if (res.statusCode == 200) {
      var decodedData = jsonDecode(res.body);
      newsApiResModel = NewsApiResModel.fromJson(decodedData);
    } else {
      log("failed");
    }
    isLoading = false;
    notifyListeners();
  }
}
