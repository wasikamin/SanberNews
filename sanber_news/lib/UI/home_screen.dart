import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanber_news/UI/news_page.dart';
import 'package:sanber_news/UI/profile_screen.dart';
import 'package:sanber_news/widget/categorytile.dart';
import 'package:sanber_news/widget/custom_text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Api
  String url =
      'https://newsapi.org/v2/top-headlines?country=ca&pageSize=10&apiKey=fbe06514d95345069b06efede5e06735';
  List? data;
  //auth
  final user = FirebaseAuth.instance.currentUser!;
  //var home
  final TextEditingController _searchController = TextEditingController();
  final List categories = [
    "sport",
    "entertainment",
    "health",
    "business",
    "science"
  ];

  String title = "";
  String profile = "";

  void initState() {
    _getRefreshData();
    super.initState();
  }

  //get user data from firestore
  Future<void> getUserData(BuildContext context) async {
    var userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((snapshot) => profile = snapshot['profile']);
    print(profile);
  }

  //refresh data
  Future<void> _getRefreshData() async {
    this.getJsonData(context);
    this.getUserData(context);
  }

  //get data from api
  Future<void> getJsonData(BuildContext context) async {
    var response = await http.get(Uri.parse(url));
    print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['articles'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 20,
          ),
          Text(
            "Sanber",
            style: GoogleFonts.roboto(
                color: Color.fromARGB(255, 106, 106, 106),
                fontWeight: FontWeight.bold),
          ),
          Text(
            "News",
            style: GoogleFonts.roboto(
                color: Color.fromARGB(255, 71, 91, 216),
                fontWeight: FontWeight.bold),
          )
        ]),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              icon: CircleAvatar(
                backgroundImage: NetworkImage(profile),
              ),
            ),
          )
        ],
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: RefreshIndicator(
        onRefresh: _getRefreshData,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 60,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 5),
                    margin: EdgeInsets.only(
                      right: 10,
                    ),
                    child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              title = "${categories[index]}";
                              url =
                                  'https://newsapi.org/v2/top-headlines?category=${categories[index]}&pageSize=10&apiKey=fbe06514d95345069b06efede5e06735';
                              getJsonData(context);
                            });
                          },
                          child: CategoryTile(
                            categoryName: categories[index],
                            opacity: title == categories[index] ? 0.7 : 0.3,
                            margin: title == categories[index] ? 7 : 5,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: data == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data == null ? 0 : data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.only(top: 3),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => News(
                                                    description: data![index]
                                                        ['description'],
                                                    image: data![index]
                                                        ['urlToImage'],
                                                    title: data![index]
                                                        ['title'],
                                                    profile: profile,
                                                    author: data![index]
                                                                ['author'] ==
                                                            null
                                                        ? "Anonim"
                                                        : data![index]
                                                            ['author'],
                                                    date: data![index][
                                                                'publishedAt'] ==
                                                            null
                                                        ? "-"
                                                        : data![index]
                                                            ['publishedAt'],
                                                  )));
                                    },
                                    child: Row(
                                      children: [
                                        if (data![index]['urlToImage'] != null)
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                                minWidth: 100,
                                                maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width),
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                topRight: Radius
                                                                    .circular(
                                                                        8)),
                                                        child: Image.network(
                                                          data![index]
                                                              ['urlToImage'],
                                                        ),
                                                      ),
                                                      Positioned(
                                                          bottom: 0,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3),
                                                            height: 50,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient: LinearGradient(
                                                                  begin: Alignment
                                                                      .bottomCenter,
                                                                  end: Alignment.topCenter,
                                                                  colors: [
                                                                    Colors
                                                                        .black,
                                                                    Color
                                                                        .fromARGB(
                                                                            31,
                                                                            29,
                                                                            29,
                                                                            29)
                                                                  ]),
                                                            ),
                                                            child: Text(
                                                              data![index]
                                                                  ['title'],
                                                              style: GoogleFonts.roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  if (data![index]['urlToImage'] != null)
                                    Divider()
                                ],
                              ),
                            );
                          }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
