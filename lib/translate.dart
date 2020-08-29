import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:auto_size_text/auto_size_text.dart';

var text = " ";
int f = 0;
void h1() {
  f = 1;
}

void h2(){
  f = 2;
}

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  File pickedImage;
  Future<File> imgfile;
  var f1;

  Widget showImage() {
    if (imgfile == null && f == 1) {
      // ignore: deprecated_member_use
      text = "";
      imgfile = ImagePicker.pickImage(source: ImageSource.gallery);
    }
    if (imgfile == null && f == 2) {
      text = "";
      // ignore: deprecated_member_use
      imgfile = ImagePicker.pickImage(source: ImageSource.camera);
    }
    return FutureBuilder<File>(
      future: imgfile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        f1 = snapshot.data;
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          print("c1");
          return Container(
            width: 200,
            height: 200,
            child: Image.file(
              snapshot.data,
              width: 300,
              height: 200,
              alignment: Alignment.center,
            ),
          );
        } else if (snapshot.error != null) {
          print("c2");
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          print("c3");
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          );
        }
      },
    );
  }

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(f1);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        setState(() {
          text = text + line.text + ' ';
        });
      }
      text = text + '\n';
    }
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: new Text("OCR"),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      showImage(),
                    ])),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                readText();
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.indigo[600],
                  ),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    "Show Text",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200.0,
              height: 250.0,
              child: AutoSizeText(
                text.toString(),
                overflow: TextOverflow.clip,
                style: TextStyle(fontSize: 30.0),
                maxLines: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor: Colors.indigo[600],
                  child: Icon(
                    Icons.compare_arrows,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TextTranslator()));
                  },
                ),
              ],
            ),
          ]),
        ));
  }
}

class TextTranslator extends StatefulWidget {
  @override
  _TextTranslatorState createState() => _TextTranslatorState();
}

class _TextTranslatorState extends State<TextTranslator> {
  String language2 = 'English';
  GoogleTranslator translator = new GoogleTranslator();
  String out = ' ';
  String l = 'en';
  final lang = TextEditingController();

  translate(String l2, String display) {
    l = 'en';
    if (l2 == 'Hindi') {
      l = 'hi';
    } else if (l2 == 'Gujarati') {
      l = 'gu';
    } else if (l2 == 'kannada') {
      l = 'kn';
    } else if (l2 == 'Tamil') {
      l = 'ta';
    } else if (l2 == 'Urdu') {
      l = 'ur';
    } else if (l2 == 'Malyalam') {
      l = 'ml';
    } else if (l2 == 'Odia') {
      l = 'or';
    } else if (l2 == 'Punjabi') {
      l = 'pa';
    } else if (l2 == 'Sindhi') {
      l = 'sd';
    } else if (l2 == 'Telugu') {
      l = 'tl';
    } else if (l2 == 'Marathi') {
      l = 'mr';
    }
    translator.translate(display, to: l).then((output) {
      setState(() {
        out = output.toString();
      });
      print(out);
    });
  }

  speak(String text) async {
    FlutterTts flutterTts;
    flutterTts = FlutterTts();
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Text Translate"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200.0,
              height: 200.0,
              child: AutoSizeText(
                text.toString(),
                overflow: TextOverflow.clip,
                style: TextStyle(fontSize: 27.0),
                maxLines: 15,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Choose Language:    ",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                DropdownButton<String>(
                  value: language2,
                  //icon: Icon(Icons.arrow_drop_down),
                  onChanged: (String lang) {
                    setState(() {
                      language2 = lang;
                    });
                  },
                  items: <String>[
                    'Bengali',
                    'English',
                    'Gujarati',
                    'Hindi',
                    'Kannada',
                    'Marathi',
                    'Malyalam',
                    'Odia',
                    'Punjabi',
                    'Sindhi',
                    'Tamil',
                    'Urdu'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                translate(language2, text);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.cyan,
                ),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text(
                  "Translate",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200.0,
              height: 150.0,
              child: SingleChildScrollView(
                child: AutoSizeText(
                  out.toString(),
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
                  minFontSize: 18,
                ),
              ),
            ),
            FloatingActionButton(
                elevation: 10,
                focusColor: Colors.blue,
                autofocus: true,
                backgroundColor: Colors.cyan,
                child: Icon(Icons.mic),
                onPressed: () {
                  speak(out);
                }),
          ],
        ),
      ),
    );
  }
}