import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class Custombuttom extends StatelessWidget {
  const Custombuttom({super.key, required this.innertext, required this.ontap});
  final String innertext;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),

          height: 50,
          child: Center(
            child: Text(
              innertext,
              style: TextStyle(color: kPrimaryColor, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
