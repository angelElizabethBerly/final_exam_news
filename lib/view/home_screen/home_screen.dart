// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_exam_news/controller/home_screen_controller.dart';
import 'package:final_exam_news/view/detailed_sceen/detailed_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeScreenController>().getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProviderObj = context.watch<HomeScreenController>();

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        actions: [
          Icon(Icons.square),
          Icon(Icons.grid_view_rounded),
          Icon(Icons.list)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Business",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Column(
                  children: List.generate(
                      homeProviderObj.newsApiResModel?.articles?.length ?? 0,
                      (index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailedScreen(
                                          newsApiResModel:
                                              homeProviderObj.newsApiResModel,
                                          index: index)));
                            },
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  height: 100,
                                  width: 150,
                                  child: CachedNetworkImage(
                                    imageUrl: homeProviderObj.newsApiResModel
                                            ?.articles?[index].urlToImage
                                            .toString() ??
                                        "",
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  // child: Image.network(homeProviderObj
                                  //         .newsApiResModel
                                  //         ?.articles?[index]
                                  //         .urlToImage ??
                                  //     ""),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(
                                              homeProviderObj.newsApiResModel
                                                      ?.articles?[index].title
                                                      .toString() ??
                                                  "",
                                              maxLines: 3,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          child: Text(
                                              "By ${homeProviderObj.newsApiResModel?.articles?[index].author.toString()}"),
                                        )
                                      ]),
                                )
                              ],
                            ),
                          )))
            ],
          ),
        ),
      ),
    );
  }
}
