import 'package:blogger/myHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Body(),
    );
  }
}


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late User user;

  @override
  void initState(){
    super.initState();
    signOut();
  }
  void click(){
    signInWithGoogle().then((userCredential) => {
        this.user = userCredential.user!,
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyHomePage(this.user)))
    });
  }
  void unclick(){
    signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SignInButton(
            Buttons.Google,
            onPressed: click,
            padding: EdgeInsets.all(10),
          ),
          OutlinedButton(onPressed: unclick, child: Text("sign out"))
        ],
      )
    );
  }
}

