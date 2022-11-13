import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.obscure = false});
  final TextEditingController controller;
  final String label;
  final bool obscure;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: label),
        obscureText: obscure,
      ),
    );
  }
}
