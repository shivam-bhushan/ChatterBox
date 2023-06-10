// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thewall1/components/text_field.dart';
import 'package:thewall1/components/wall_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //controller
  final inputTextController = TextEditingController();
  //current user
  final currentUser = FirebaseAuth.instance.currentUser!;
  //sign out
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  //send to wall
  void sendToChat() {
    //only post if there is content in the post field
    if (inputTextController.text.isNotEmpty) {
      //save to firebase
      FirebaseFirestore.instance.collection('UserPosts').add({
        'UserEmail': currentUser.email,
        'Message': inputTextController.text,
        'TimeStamp': Timestamp.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Icon(Icons.workspaces_filled, size: 40),
        ),
        actions: [
          IconButton(
              onPressed: signOut, icon: Icon(Icons.exit_to_app, size: 30)),
        ],
      ),
      body: Center(
        child: Column(children: [
          //Chatter box

          Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('UserPosts')
                      .orderBy('TimeStamp', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            //get the message
                            final post = snapshot.data!.docs[index];
                            return WallPost(
                                message: post['Message'],
                                user: post['UserEmail']);
                          });
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  })),

          //text input

          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                      controller: inputTextController,
                      hintText: 'Chatter here...',
                      obscureText: false),
                ),
                SizedBox(
                  width: 3,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: ElevatedButton(
                    onPressed: sendToChat,
                    child: Icon(Icons.arrow_circle_right_outlined, size: 30),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        padding: const EdgeInsets.all(14)),
                  ),
                ),
              ],
            ),
          ),

          //logged in as
          Text("Logged in as: " + currentUser.email!),
        ]),
      ),
    );
  }
}
