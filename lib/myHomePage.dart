import 'dart:async';

import 'package:blogger/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:blogger/post.dart';
import 'package:blogger/textInputWidget.dart';
import 'package:blogger/postList.dart';
class MyHomePage extends StatefulWidget {

  final User user;
  const MyHomePage(this.user, {Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];
  String datetime = DateTime.now().toString();
  void newPost(String text){
    var post = new Post(body: text, author: widget.user.displayName!, cutime: datetime);
    post.setId(savePost(post));
    setState(() {
      posts.add(post);
    });
  }
  void updateMessages(){
    getAllMessages().then((posts) => {
      setState(() {
        this.posts = posts;
      })
    });
  }
  Timer? timer;
  @override
  void initState(){
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => updateMessages());
    updateMessages();
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogger'),
      ),
      body: Column(
        children: [
          Expanded(
              child: PostList(posts, widget.user)
          ),
          TextInputWidget(newPost),
        ],
      ),
    );
  }
}