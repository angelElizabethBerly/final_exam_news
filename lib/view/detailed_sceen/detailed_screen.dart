// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_exam_news/model/news_api_resmodel.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DetailedScreen extends StatelessWidget {
  const DetailedScreen(
      {super.key, required this.newsApiResModel, required this.index});
  final NewsApiResModel? newsApiResModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Share.share(
                    "Check out this latest news: ${newsApiResModel?.articles?[index].url}");
              },
              icon: Icon(Icons.share))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                newsApiResModel?.articles?[index].title.toString() ?? "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            SizedBox(height: 10),
            CachedNetworkImage(
              imageUrl:
                  newsApiResModel?.articles?[index].urlToImage.toString() ?? "",
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(height: 10),
            Text(newsApiResModel?.articles?[index].content.toString() ?? "")
          ],
        ),
      ),
    );
  }
}
