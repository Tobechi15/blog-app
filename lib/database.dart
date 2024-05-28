import 'package:firebase_database/firebase_database.dart';
import 'package:blogger/post.dart';

final databaseReference = FirebaseDatabase.instance.ref();
DatabaseReference savePost(Post post) {
  var id = databaseReference.child('posts/').push();
  print(post.toJson());
  id.set(post.toJson());
  getAllMessages();
  return id;
}

void updatePost(Post post, DatabaseReference id) {
  id.update(post.toJson());
}

Future<List<Post>> getAllMessages() async {
  DataSnapshot dataSnapshot = (await databaseReference.child("posts/").orderByKey().limitToLast(5).once()).snapshot;
  List<Post> posts = [];

  print('--------------------------------------------------------------------');
  if (dataSnapshot.value != null) {
    (dataSnapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
      Post post = createPost(value);
      print(value);
      post.setId(databaseReference.child('posts/' + key));
      posts.add(post);
    });
  }
  return posts;
}
