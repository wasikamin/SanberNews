import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanber_news/UI/home_screen.dart';
import 'package:sanber_news/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passConfirmController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(35, 82, 35, 0),
        child: ListView(
          children: <Widget>[
            Text(
              "Register",
              style: GoogleFonts.roboto(
                  color: Color.fromARGB(255, 71, 91, 216),
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Create new account",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 71, 91, 216),
                  fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            CustomTextField(
                controller: _firstNameController, label: "First Name"),
            CustomTextField(
                controller: _lastNameController, label: "Last Name"),
            CustomTextField(controller: _emailController, label: "Email"),
            CustomTextField(
                controller: _passwordController,
                label: "Password",
                obscure: true),
            CustomTextField(
                controller: _passConfirmController,
                label: "Password Confirmation",
                obscure: true),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                onPressed: signUp,
                child: Text("Register"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 71, 91, 216),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)))),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "cancel",
                  style: GoogleFonts.roboto(
                      color: Color.fromARGB(255, 71, 91, 216)),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) => addUserData(
              value.user!.uid,
              _firstNameController.text.trim(),
              _lastNameController.text.trim(),
              _emailController.text.trim()))
          .then((value) =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomeScreen(),
              )));
      ;
    }
  }

  Future<void> addUserData(uid, String first, String last, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'id': uid,
      'first name': first,
      'last name': last,
      'email': email,
      'profile': 'https://ui-avatars.com/api/?name=$first+$last',
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() == _passConfirmController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }
}
