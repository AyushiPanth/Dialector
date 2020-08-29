import 'package:flutter/material.dart';

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  List languages = [
    "        Hindi",
    "       Marathi",
    "       Gujarati",
    "       Telugu",
    "      Tamil",
    "      Kannada",
    "      Bangla",
    "      Punjabi",
    "    Malayalam"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Common Phrases", style: TextStyle(fontSize: 25)),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(20),
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: languages.length,
        itemBuilder: (BuildContext context, int index) {
          //from here
          return Container(
            child: new Card(
              shadowColor: Colors.blueAccent,
              elevation: 8.0,
              child: new InkResponse(
                onTap: () {
                  if (index == 0)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Hindi()),
                    );
                  if (index == 1)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Marathi()),
                    );
                  if (index == 2)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Gujarati()),
                    );
                  if (index == 3)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Telugu()),
                    );
                  if (index == 4)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Tamil()),
                    );
                  if (index == 5)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Kannada()),
                    );
                  if (index == 6)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Bangla()),
                    );
                  if (index == 7)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Punjabi()),
                    );

                  if (index == 8)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Malayalam()),
                    );
                },
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(20)),
                    if (index == 0)
                      Center(
                        child: new Text(
                          "हिन्दी",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                    if (index == 1)
                      Center(
                        child: new Text(
                          "मराठी",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                    if (index == 2)
                      Center(
                        child: new Text(
                          "ગુજરાતી",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                    if (index == 3)
                      Center(
                        child: new Text(
                          "తెలుగు",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                    if (index == 4)
                      Center(
                        child: new Text(
                          "தமிழ்",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                    if (index == 5)
                      Center(
                        child: new Text(
                          "ಕನ್ನಡ",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                    if (index == 6)
                      Center(
                        child: new Text(
                          "বাংলা",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                    if (index == 7)
                      Center(
                        child: new Text(
                          "ਪੰਜਾਬੀ",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                    if (index == 8)
                      Center(
                        child: new Text(
                          "മലയാളം",
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                    Container(
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: new Text(
                        languages[index],
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Hindi extends StatefulWidget {
  @override
  _HindiState createState() => _HindiState();
}

class _HindiState extends State<Hindi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "आम वाक्यांश",
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Image(
            image: AssetImage('Pdfimages/hindii.png'),
          ),
        ));
  }
}

class Marathi extends StatefulWidget {
  @override
  _MarathiState createState() => _MarathiState();
}

class _MarathiState extends State<Marathi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "सामान्य वाक्ये",
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Image(
            image: AssetImage('Pdfimages/marathii.png'),
          ),
        ));
  }
}

class Gujarati extends StatefulWidget {
  @override
  _GujaratiState createState() => _GujaratiState();
}

class _GujaratiState extends State<Gujarati> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("સામાન્ય શબ્દસમૂહો", style: TextStyle(fontSize: 25)),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Image(
            image: AssetImage('Pdfimages/gujaratii.png'),
          ),
        ));
  }
}

class Telugu extends StatefulWidget {
  @override
  _TeluguState createState() => _TeluguState();
}

class _TeluguState extends State<Telugu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("సాధారణ పదబంధాలు", style: TextStyle(fontSize: 25)),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Image(
            image: AssetImage('Pdfimages/teluguu.png'),
          ),
        ));
  }
}

class Tamil extends StatefulWidget {
  @override
  _TamilState createState() => _TamilState();
}

class _TamilState extends State<Tamil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("பொதுவான சொற்றொடர்கள்", style: TextStyle(fontSize: 25)),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Image(
            image: AssetImage('Pdfimages/tamila.png'),
          ),
        ));
  }
}

class Kannada extends StatefulWidget {
  @override
  _KannadaState createState() => _KannadaState();
}

class _KannadaState extends State<Kannada> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("ಸಾಮಾನ್ಯ ನುಡಿಗಟ್ಟುಗಳು", style: TextStyle(fontSize: 25)),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Image(
            image: AssetImage('Pdfimages/kannadaa.png'),
          ),
        ));
  }
}

class Bangla extends StatefulWidget {
  @override
  _BanglaState createState() => _BanglaState();
}

class _BanglaState extends State<Bangla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("সাধারণ বাক্যাংশ", style: TextStyle(fontSize: 25)),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Image(
            image: AssetImage('Pdfimages/banglaa.png'),
          ),
        ));
  }
}

class Punjabi extends StatefulWidget {
  @override
  _PunjabiState createState() => _PunjabiState();
}

class _PunjabiState extends State<Punjabi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("ਆਮ ਵਾਕੰਸ਼", style: TextStyle(fontSize: 25)),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Image(
            image: AssetImage('Pdfimages/punjabii.png'),
          ),
        ));
  }
}

class Malayalam extends StatefulWidget {
  @override
  _MalayalamState createState() => _MalayalamState();
}

class _MalayalamState extends State<Malayalam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("സാധാരണ ശൈലികൾ", style: TextStyle(fontSize: 20)),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Image(
            image: AssetImage('Pdfimages/malayalamm.png'),
          ),
        ));
  }
}