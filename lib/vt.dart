import 'dart:math';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Speech to text",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAvailable = false;
  String finalAnswer = "";
  String finalStatus = "";
  String finalError = "";
  String speechOut = "";
  String _currentLocaleID = "";
  List _localeNames = [];
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  double level = 0;

  String language2 = 'English';
  var text;
  GoogleTranslator translator = new GoogleTranslator();
  String out = ' ';
  final SpeechToText speech = SpeechToText();
  final FlutterTts fluttertts = FlutterTts();

  speak(String text) async {
    await fluttertts.setLanguage(_currentLocaleID);
    await fluttertts.setVoice(_currentLocaleID);
    await fluttertts.speak(text);
  }

  translate(String l2, String display) {
    String l = _currentLocaleID;
    if (l2 == 'Hindi') {
      l = 'hi';
    } else if (l2 == 'English') {
      l = 'en';
    } else if (l2 == 'Gujarati') {
      l = 'gu';
    } else if (l2 == 'Kannada') {
      l = 'kn';
    } else if (l2 == 'Tamil') {
      l = 'ta';
    } else if (l2 == 'Malyalam') {
      l = 'ml';
    } else if (l2 == 'Punjabi') {
      l = 'pa';
    } else if (l2 == 'Telugu') {
      l = 'tl';
    } else if (l2 == 'Marathi') {
      l = 'mr';
    } else if (l2 == 'Bangla') {
      l = 'bn';
    }
    translator.translate(finalAnswer, to: l).then((output) {
      setState(() {
        out = output.toString().substring(0, output.toString().indexOf("-"));
      });
      print(out);
    });
  }

  void initState() {
    super.initState();
  }

  void initSpeechState() async {
    bool isAvailable = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (isAvailable) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleID = systemLocale.localeId;
    }

    setState(() {
      _isAvailable = isAvailable;
    });
  }

  void startRecognition() {
    speech.listen(
      onResult: resultListener,
      localeId: _currentLocaleID,
      listenFor: Duration(seconds: 10),
      listenMode: ListenMode.confirmation,
      onSoundLevelChange: soundLevelManager,
    );
    setState(() {});
  }

  void stopRecognition() {
    speech.stop();
    setState(() {
      level = 0;
    });
  }

  void cancelRecognition() {
    speech.stop();
    setState(() {
      finalAnswer = "";
      out = "";
      speechOut = "";
      level = 0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      finalAnswer = "${result.recognizedWords} - ${result.finalResult}";
      speechOut = finalAnswer.substring(0, finalAnswer.indexOf("-"));
    });
  }

  void errorListener(SpeechRecognitionError error) {
    finalError = "${error.errorMsg} - ${error.permanent}";
  }

  void statusListener(String status) {
    setState(() {
      finalStatus = "$status";
    });
  }

  void soundLevelManager(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    setState(() {
      this.level = level;
    });
  }

  void _changeLang(selectLang) {
    setState(() {
      _currentLocaleID = selectLang;
    });
    print(selectLang);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: new Text("Dialector", style: TextStyle(fontSize: 25)),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Container(
                child: Column(children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FloatingActionButton.extended(
                        backgroundColor: Colors.red,
                        label: Text(
                          "Start Speech Recognition",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        onPressed: _isAvailable ? null : initSpeechState)
                  ]),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DropdownButton(
                      iconSize: 40.0,
                      elevation: 10,
                      focusColor: Colors.blue,
                      autofocus: true,
                      items: _localeNames
                          .map(
                            (localeName) => DropdownMenuItem(
                              value: localeName.localeId,
                              child: Text(localeName.name),
                            ),
                          )
                          .toList(),
                      value: _currentLocaleID,
                      onChanged: (selectLang) => _changeLang(selectLang)),
                ],
              )
            ])),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new FloatingActionButton(
                  backgroundColor: Colors.black,
                  hoverElevation: 30,
                  heroTag: null,
                  child: Icon(Icons.stop),
                  onPressed: speech.isListening ? stopRecognition : null,
                ),
                new FloatingActionButton(
                  backgroundColor: Colors.black,
                  hoverElevation: 30,
                  heroTag: null,
                  child: Icon(Icons.mic),
                  onPressed: !_isAvailable || speech.isListening
                      ? null
                      : startRecognition,
                ),
                new FloatingActionButton(
                  backgroundColor: Colors.black,
                  hoverElevation: 30,
                  heroTag: null,
                  child: Icon(Icons.cancel),
                  onPressed: speech.isListening ? null : cancelRecognition,
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.all(6),
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    //background color of box
                    BoxShadow(
                      color: Colors.blueAccent,
                      blurRadius: 10.0, // soften the shadow
                      spreadRadius: 1.0, //extend the shadow
                      offset: Offset(
                        3.0, // Move to right 10  horizontally
                        3.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(40)),
                  border: Border.all(
                      width: 3, color: Colors.black, style: BorderStyle.solid)),
              child: Column(children: <Widget>[
                Padding(padding: EdgeInsets.all(10)),
                Center(
                  child: Text(
                    "Recognized Text",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Center(
                      child: Text(
                    speechOut,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  )),
                )
              ]),
            ),
            Container(
                child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          DropdownButton<String>(
                            iconSize: 40.0,
                            elevation: 10,
                            focusColor: Colors.blue,
                            autofocus: true,
                            value: language2,
                            onChanged: (String lang) {
                              setState(() {
                                language2 = lang;
                              });
                            },
                            items: <String>[
                              'English',
                              'Gujarati',
                              'Hindi',
                              'Kannada',
                              'Marathi',
                              'Malyalam',
                              'Punjabi',
                              'Tamil',
                              'Telugu',
                              'Bangla'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new RaisedButton(
                            hoverElevation: 30,
                            color: Colors.black,
                            textColor: Colors.white,
                            onPressed: () {
                              translate(language2, text);
                            },
                            child: const Text(
                              'Translate',
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                          new RaisedButton(
                            hoverElevation: 30,
                            child: const Text(
                              "Speak",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w500),
                            ),
                            color: Colors.black,
                            textColor: Colors.white,
                            onPressed: () {
                              speak(out);
                            },
                          ),
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        height: 250,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              //background color of box
                              BoxShadow(
                                color: Colors.blueAccent,
                                blurRadius: 10.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                                offset: Offset(
                                  3.0, // Move to right 10  horizontally
                                  3.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40)),
                            border: Border.all(
                                width: 3,
                                color: Colors.black,
                                style: BorderStyle.solid)),
                        child: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(10)),
                            Center(
                                child: Text("Text in " + language2,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontSize: 20))),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              '$out',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 23,
                              ),
                            ),
                          ],
                        ))
                  ]),
            ))
          ]),
        ));
  }
}
