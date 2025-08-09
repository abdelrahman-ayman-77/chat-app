import 'package:chat_app/constants.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/chatpage.dart';
import 'package:chat_app/pages/loginpage.dart';
import 'package:chat_app/pages/registerpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Loginpage().id: (context) => Loginpage(),
        Registerpage().id: (context) => Registerpage(),
        Chatpage().id: (context) => Chatpage(),
      },
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: kPrimaryColor.withOpacity(0.4), // Highlight color
          selectionHandleColor: kPrimaryColor, // Handle color
          cursorColor: kPrimaryColor, // Cursor color (optional)
        ),
      ),
      home: Loginpage(),
    );
  }
}
