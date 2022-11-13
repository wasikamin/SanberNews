import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryTile extends StatelessWidget {
  final String categoryName;
  final double opacity;
  final double margin;
  const CategoryTile(
      {super.key,
      required this.categoryName,
      this.opacity = 0.4,
      this.margin = 5});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(opacity), BlendMode.dstATop),
              fit: BoxFit.cover,
              image: AssetImage("assets/images/$categoryName.png"))),
      margin: EdgeInsets.all(margin),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
              child: Text(
            "$categoryName",
            style: GoogleFonts.roboto(
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 12, 26, 115)),
          ))
        ],
      ),
    );
  }
}
