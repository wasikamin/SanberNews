import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class News extends StatelessWidget {
  final String profile;
  final String image;
  final String description;
  final String title;
  final String author, date;
  const News(
      {super.key,
      required this.image,
      required this.description,
      required this.title,
      required this.profile,
      this.author = "anonim",
      this.date = "-"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Color.fromARGB(255, 106, 106, 106)),
        title: Row(children: [
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
        actions: [
          Container(
            margin: EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                backgroundImage: NetworkImage(profile),
              ),
            ),
          )
        ],
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 235, 235, 235),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                title,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(bottom: 4),
              child: Text(
                author,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 114, 114, 114)),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(bottom: 9),
              child: Text(
                date.substring(0, 10),
                style: GoogleFonts.roboto(
                    color: Color.fromARGB(255, 114, 114, 114)),
              ),
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(image)),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                description,
                style: GoogleFonts.roboto(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
