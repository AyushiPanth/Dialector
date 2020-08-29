import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'apikey.dart';
import 'web.dart';

class NewsPage extends StatefulWidget {
  final String name;
  NewsPage(this.name);
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  FlutterTts tts = FlutterTts();

  getnews() async {
    var url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apikey&category=${widget.name}';

    var response = await http.get(url);
    var result = jsonDecode(response.body);
    List<News> newslist = List<News>();
    for (var article in result['articles']) {
      News news = News(article['title'], article['urlToImage'], article['url'],
          article['description']);
      newslist.add(news);
    }
    return newslist;
  }

  speak(String text) async {
    print(await tts.getLanguages);
    await tts.setLanguage('en-IN');
    await tts.setPitch(1);
    await tts.setVolume(1.0);
    await tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("News"),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 30.0),
              child: Text("Top ${widget.name} News",
                  style: GoogleFonts.montserrat(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.red)),
            ),
            FutureBuilder(
                future: getnews(),
                builder: (BuildContext context, dataSnapshot) {
                  if (!dataSnapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dataSnapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            decoration: BoxDecoration(
                              color: new Color.fromRGBO(255, 250, 250, 0.8),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 3.0,
                                  offset: Offset(
                                    4.0, // Move to right 10  horizontally
                                    4.0, // Move to bottom 5 Vertically
                                  ),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    dataSnapshot.data[index].title,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (dataSnapshot.data[index].image != null)
                                  Image(
                                    image: NetworkImage(
                                        dataSnapshot.data[index].image),
                                    fit: BoxFit.fill,
                                  ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () => speak(
                                          dataSnapshot.data[index].description),
                                      child: Icon(
                                        Icons.play_arrow,
                                        size: 40,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await tts.stop();
                                      },
                                      child: Icon(
                                        Icons.stop,
                                        size: 40,
                                        color: Colors.black,
                                      ),
                                    ),
                                    RaisedButton(
                                      disabledColor: Colors.purpleAccent,
                                      padding: EdgeInsets.all(1.0),
                                      elevation: 10,
                                      color: Colors.black,
                                      splashColor: Colors.cyan[200],
                                      colorBrightness: Brightness.dark,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ViewWeb(
                                                    dataSnapshot
                                                        .data[index].url)));
                                      },
                                      child: Text(
                                        "View",
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        );
                      });
                })
          ],
        ),
      ),
    );
  }
}

class News {
  final String title;
  final String image;
  final String url;
  final String description;

  News(this.title, this.image, this.url, this.description);
}