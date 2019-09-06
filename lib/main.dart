import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "login ui",
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<String> signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = new GoogleSignIn();

    GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;

        assert(user.email != null);
        assert(user.displayName != null);
    return user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            "images/one.png",
            fit: BoxFit.fitHeight,
            color: Colors.black38,
            colorBlendMode: BlendMode.darken,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:
                    Image.asset("images/good.jpg", height: 150.0, width: 150.0),
              ),
              Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      height: 350.0,
                      width: 350.0,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15.0),
                      decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(23.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5.0),
                            child: TextField(
                              autocorrect: false,
                              autofocus: false,
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 25.0,
                              ),
                              decoration: InputDecoration(
                                hintText: "Username",
                                hintMaxLines: 2,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5.0),
                            child: TextField(
                              autocorrect: false,
                              autofocus: false,
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 25.0,
                              ),
                              decoration: InputDecoration(
                                hintText: "Password",
                                // hintMaxLines: 2,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Forget Password ?",
                                  style: TextStyle(
                                      fontSize: 19.0, color: Colors.white),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {},
                                child: Text("Login with Fb"),
                                color: Colors.limeAccent,
                                splashColor: Colors.purple,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 20.0),
                              ),
                              SizedBox(width: 19.0),
                              FlatButton(
                                onPressed: () {
                                  signInWithGoogle().then((user){
                                    print('user id $user');
                                  });
                                },
                                child: Text("Login with gmail",
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.blue,
                                splashColor: Colors.limeAccent,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 20.0),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
