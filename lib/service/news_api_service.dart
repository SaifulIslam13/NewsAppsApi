import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapi/model/news_model.dart';

class NewsApiService {
  Future<List<Articles>> fetchNewsData() async {
    List<Articles> newsList = [];
    try {
      var Link =
          "https://newsapi.org/v2/everything?q=bitcoin&apiKey=1039e6f90e5a4cb2a6193bcb7a1127b4&pageSize=10";

      var responce = await http.get(Uri.parse(Link));
      print("responce is${responce.body}");
      var data = jsonDecode(responce.body);
      Articles articles;
      for (var i in data["articles"]) {
        articles = Articles.fromJson(i);
        newsList.add(articles);
      }
    } catch (e) {
      print("The problem is $e");
    }
    return newsList;
  }
}
