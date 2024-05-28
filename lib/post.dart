import 'package:blogger/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Post {
  late String body;
  late String author;
  Set userLiked = {};
  String cutime;
  late DatabaseReference ide;

  Post({required this.body, required this.author, required this.cutime});

  void likePost(User user){
    if(userLiked.contains(user.uid)){
      userLiked.remove(user.uid);
    }
    else{
      userLiked.add(user.uid);
    }
    this.update();
  }
  void update(){
    updatePost(this, ide);
  }
  void setId(DatabaseReference id){
    ide = id;
  }
  Map<String, dynamic> toJson() {
    return {'author': author, 'userLiked': userLiked.toList(), 'body': body, 'cutime':cutime};
  }
}
Post createPost(record){
  Map<String, dynamic> attributes = {
    'author': '',
    'userLiked': [],
    'body':'',
    'cutime': 0
  };

  record.forEach((key, value) => {
    attributes[key] = value
  });
  Post post = Post(body: attributes['body'], author: attributes['author'], cutime: attributes['cutime']);

  post.userLiked = Set.from(attributes['userLiked']);
  return post;
}