import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanber_news/main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map? userData;
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> getUserData(BuildContext context) async {
    var fetch = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot doc) {
      setState(() {
        userData = doc.data() as Map<String, dynamic>;
      });
    });
    print(userData);
  }

  Future<void> getData() async {
    this.getUserData(context);
  }

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Color.fromARGB(255, 106, 106, 106)),
      ),
      body: userData == null
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Stack(children: [
              Container(
                margin: EdgeInsets.only(bottom: 100),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userData!["profile"]),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 10),
                      child: Text(
                        userData!["first name"] + " " + userData!["last name"],
                        style: GoogleFonts.roboto(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 71, 90, 216)),
                      ),
                    ),
                    Text(
                      userData!["email"],
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 71, 90, 216)),
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 50,
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckAuth()));
                        },
                        child: const Text('Logout'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[300]),
                      ))),
            ]),
    );
  }
}
