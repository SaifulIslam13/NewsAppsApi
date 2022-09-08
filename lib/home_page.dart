import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:newsapi/const/const.dart';
import 'package:newsapi/model/news_model.dart';
import 'package:newsapi/service/news_api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Articles> newsList = [];
  @override
  void didChangeDependencies() async {
    newsList = await NewsApiService().fetchNewsData();
    setState(() {});
    super.didChangeDependencies();
  }

  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          'News app',
          style: mystyle(18, Colors.black, FontWeight.bold),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: 20,
                    color: Colors.black,
                  ))),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //heading
              Text(
                "All News",
                style: mystyle(20, Colors.black, FontWeight.bold),
              ),
              //page transition
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentIndex > 1
                                ? currentIndex = currentIndex - 1
                                : currentIndex = currentIndex;
                          });
                        },
                        child: Text("Prev")),
                    Flexible(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  setState(() {
                                    currentIndex = index + 1;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 8),
                                  alignment: Alignment.center,
                                  color: currentIndex == index + 1
                                      ? Colors.blue
                                      : Colors.white,
                                  width: 30,
                                  child: Text("${index + 1}"),
                                ));
                          }),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentIndex <= 4
                                ? currentIndex = currentIndex + 1
                                : currentIndex = currentIndex;
                          });
                        },
                        child: Text("Next"))
                  ],
                ),
              ),

              //listview builder
              ListView.builder(
                  clipBehavior: Clip.hardEdge,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        height: 130,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            Positioned(
                              child: Container(
                                height: 50,
                                width: 10,
                                color: Colors.blue,
                              ),
                              top: 0,
                              left: 0,
                            ),
                            Positioned(
                              child: Container(
                                height: 50,
                                width: 10,
                                color: Colors.blue,
                              ),
                              right: 0,
                              bottom: 0,
                            ),
                            Positioned(
                              child: Container(
                                height: 10,
                                width: 50,
                                color: Colors.blue,
                              ),
                              top: 0,
                              left: 0,
                            ),
                            Positioned(
                              child: Container(
                                height: 10,
                                width: 50,
                                color: Colors.blue,
                              ),
                              bottom: 0,
                              right: 0,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Container(
                                    height: 120,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${newsList[index].urlToImage}"),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 200,
                                      child: AutoSizeText(
                                        "${newsList[index].title}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        maxFontSize: 14,
                                        minFontSize: 14,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later,
                                          color: Colors.grey,
                                        ),
                                        Text("Less than a minuite")
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.link,
                                              color: Colors.blue,
                                            )),
                                        Text("${newsList[index].publishedAt}")
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
