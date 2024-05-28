import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:blogger/post.dart';

class PostList extends StatefulWidget {

  final List<Post> ListItems;

  final User user;

  PostList(this.ListItems, this.user);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callback){
    this.setState((){
      callback();
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.widget.ListItems.length,
        itemBuilder: (context,index){
          var post = this.widget.ListItems[index];
          return Card(
            child: Row(
              children: <Widget>[
                Expanded(child: ListTile(
                  title: Text(post.body),
                  subtitle: Text(post.author),
                )),
                Row(
                  children: [
                    Container(
                      child: Text(
                        post.userLiked.length.toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    ),
                    IconButton(
                        icon: Icon(Icons.thumb_up),
                        onPressed:() => this.like(() => post.likePost(widget.user)),
                        color: post.userLiked.contains(widget.user.uid) ? Colors.green : Colors.black
                    )
                  ],
                )
              ],
            ),
          );
        }
    );
  }
}
