import 'package:flutter/material.dart';

class Inputtextfield extends StatelessWidget {
  const Inputtextfield({
    super.key,
    required this.hinttext,
    required this.onchange,
    required this.obsecure,
  });
  final String hinttext;
  final bool obsecure;
  final Function(String) onchange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: TextFormField(
        obscureText: obsecure,
        validator: (value) {
          if (value!.isEmpty) {
            return 'field is empty';
          }
          return null;
        },
        onChanged: onchange,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.white),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
