import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanber_news/UI/home_screen.dart';
import 'package:sanber_news/UI/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(35, 82, 35, 0),
        child: ListView(
          children: <Widget>[
            Container(
              child: Image.asset(
                "assets/icons/sanbernews_logo_reversed.png",
                height: 69,
              ),
            ),
            Center(
              child: Text(
                "SanberNews",
                style: GoogleFonts.roboto(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 71, 91, 216)),
              ),
            ),
            Center(
              child: Text(
                "Your Daily News",
                style: GoogleFonts.roboto(
                    fontSize: 10, color: Color.fromARGB(255, 71, 91, 216)),
              ),
            ),
            SizedBox(
              height: 94,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "email"),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "password"),
                obscureText: true,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Don't have an account?",
                  style: GoogleFonts.roboto(),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                    },
                    child: Text(
                      "Register",
                      style: GoogleFonts.roboto(
                          color: Color.fromARGB(255, 71, 91, 216),
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            SizedBox(
              height: 78,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                onPressed: () async {
                  await _firebaseAuth
                      .signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text)
                      .then((value) => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          )));
                },
                child: Text(
                  "Login",
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 71, 91, 216),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
