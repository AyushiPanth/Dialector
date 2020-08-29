import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'translate.dart';

var f = 0;

class OcrApp extends StatelessWidget {
  static const String _title = 'Text Recognizer';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      title: _title,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text(_title, style: TextStyle(fontSize: 25))),
        body: Center(
          child: BackgroundImage(),
        ),
      ),
    );
  }
}

var i = 0;

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image(image: AssetImage('ocr.jpeg'), fit: BoxFit.cover),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                h1();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Gallery()));
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.indigo[600],
                ),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Gallery",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 21),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                h2();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Gallery()));
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.red,
                ),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Camera",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 21),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
