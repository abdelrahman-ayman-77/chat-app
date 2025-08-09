import 'package:chat_app/constants.dart';
import 'package:chat_app/models/messagemodel.dart';
import 'package:chat_app/widgets/chatbubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  Chatpage({super.key});
  String id = 'chatpage';

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  CollectionReference messages = FirebaseFirestore.instance.collection(
    'messages',
  );
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('created_at', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Messagemodel> messageslist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageslist.add(Messagemodel.fromjson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/scholar.png', height: 50),
                  Text('Chat', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messageslist.length,
                    itemBuilder: (context, index) {
                      return messageslist[index].id == email
                          ? chatbubble(messagemodel: messageslist[index])
                          : chatbubblefriend(messagemodel: messageslist[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: textEditingController,
                    minLines: 1,
                    maxLines: null,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          messages.add({
                            'message': textEditingController.text,
                            'created_at': DateTime.now(),
                            'id': email,
                          });
                          textEditingController.clear();
                          scrollController.animateTo(
                            0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        },
                        icon: Icon(Icons.send, color: kPrimaryColor),
                      ),
                      hintText: 'Send message',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/scholar.png', height: 50),
                  Text('Chat', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            body: Text('oops there was an error'),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
