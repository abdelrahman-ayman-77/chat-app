import 'dart:io';

import 'package:chat_app/constants.dart';
import 'package:chat_app/functions/methods.dart';
import 'package:chat_app/pages/chatpage.dart';
import 'package:chat_app/pages/registerpage.dart';
import 'package:chat_app/widgets/custombuttom.dart';
import 'package:chat_app/widgets/inputtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});
  String id = 'LoginPage';
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  String? email;

  String? password;

  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formkey,
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
                      'Login',
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
                  isLoading = true;
                  setState(() {});
                  if (formkey.currentState!.validate()) {
                    try {
                      await loginuser(email!, password!);
                      Navigator.pushNamed(
                        context,
                        Chatpage().id,
                        arguments: email,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showsnackbar(context, 'user not found');
                      } else if (e.code == 'wrong-password') {
                        showsnackbar(context, 'wrong password');
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
                      showsnackbar(context, e.toString());
                    }
                    isLoading = false;
                    setState(() {});
                  } else {
                    isLoading = false;
                    setState(() {});
                  }
                },
                innertext: 'Sign In',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'don\'t have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Registerpage().id);
                    },
                    child: Text(
                      '  Sign Up',
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
