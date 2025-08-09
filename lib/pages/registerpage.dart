// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:chat_app/constants.dart';
import 'package:chat_app/functions/methods.dart';
import 'package:chat_app/pages/chatpage.dart';
import 'package:chat_app/widgets/custombuttom.dart';
import 'package:chat_app/widgets/inputtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Registerpage extends StatefulWidget {
  Registerpage({super.key});
  String id = 'RegisterPage';
  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  String? email;
  String? password;
  GlobalKey<FormState> globalkey = GlobalKey();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: globalkey,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 75),
              Image.asset(kLogo, height: 150),
              Text(
                'Scholar Chat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                ),
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Inputtextfield(
                onchange: (value) {
                  email = value;
                },
                obsecure: false,
                hinttext: 'Email',
              ),
              Inputtextfield(
                onchange: (value) {
                  password = value;
                },
                obsecure: true,
                hinttext: 'Password',
              ),
              Custombuttom(
                ontap: () async {
                  if (globalkey.currentState!.validate()) {
                    isloading = true;
                    setState(() {});
                    try {
                      await registeruser(email!, password!);
                      Navigator.pushNamed(
                        context,
                        Chatpage().id,
                        arguments: email,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showsnackbar(context, 'weak password');
                      } else if (e.code == 'email-already-in-use') {
                        showsnackbar(context, 'email already in use');
                      } else {
                        showsnackbar(
                          context,
                          'FirebaseAuth error: ${e.message}',
                        );
                      }
                    } on SocketException {
                      showsnackbar(
                        context,
                        'Network error: Please check your internet connection.',
                      );
                    } catch (e) {
                      showsnackbar(context, 'oops there was an error');
                      print(e);
                    }
                    isloading = false;
                    setState(() {});
                  } else {
                    isloading = false;
                    setState(() {});
                  }
                },
                innertext: 'Sign Up',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'already have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '  Login in',
                      style: TextStyle(
                        color: Color(0xffC7EDE6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
