import 'package:flutter/material.dart';

import 'vt.dart';
import 'news/news.dart';
import 'reference/pdfpage.dart';
import 'ocr.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dialector",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Dialector",
          style: TextStyle(fontSize: 25, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Image.asset(
            'Dialector.jpeg',
            fit: BoxFit.fitHeight,
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            padding: EdgeInsets.all(10),
            children: <Widget>[
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        width: 2,
                        style: BorderStyle.solid),
                    image: DecorationImage(
                        image: AssetImage('TTTT.jpg'), fit: BoxFit.contain),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Translator",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondRoute()));
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                    image: DecorationImage(
                        image: AssetImage('news.jpg'),
                        fit: BoxFit.fitWidth,
                        colorFilter: ColorFilter.linearToSrgbGamma()),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "News",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ThirdRoute()));
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black,
                        width: 2,
                        style: BorderStyle.solid),
                    image: DecorationImage(
                        image: AssetImage('ocr.png'), fit: BoxFit.fitWidth),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Text Recognizer",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OcrApp()));
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black,
                        width: 2,
                        style: BorderStyle.solid),
                    image: DecorationImage(
                        image: AssetImage('reference.png'),
                        fit: BoxFit.contain),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Common Phrases",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FourthRoute()));
                },
              )
            ],
          ),
        ]),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

class ThirdRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewsItem();
  }
}

class FourthRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Reference();
  }
}
