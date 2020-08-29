import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'newspage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> categorylist = [
    Category('health', 'Newsimages/health.jpg'),
    Category('Sports', 'Newsimages/sports.jpg'),
    Category('Business', 'Newsimages/business.jpg'),
    Category('Entertainment', 'Newsimages/entertainment.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("News"),
          ),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  alignment: Alignment.center,
                  child: Text(
                    "News Reader",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 50,
                        color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 80.0,
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  crossAxisCount: 2,
                  children: categorylist.map((eachcategory) {
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NewsPage(eachcategory.name))),
                      child: Container(
                          height: 70,
                          width: 50,
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(eachcategory.image),
                              fit: BoxFit.cover,
                            ),
                          )),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          )),
    );
  }
}

class Category {
  final String name;
  final String image;

  Category(this.name, this.image);
}
