import 'package:appcart/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController econtroller =
        TextEditingController(text: "sameer@gmail.com");
    final TextEditingController pcontroller =
        TextEditingController(text: "12345678");

    void login() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      // FirebaseFirestore db = FirebaseFirestore.instance;
      final String email = econtroller.text.trim();
      final String password = pcontroller.text.trim();
      try {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(email + "  Is logged in");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } catch (e) {
        print("error");
      }

      // final DocumentSnapshot snapshot =
      //     await db.collection("user").doc(user.user.uid).get();
      // final data = snapshot.data();
      // Navigator.of(context).pushNamed("/home", arguments: data);
      // print("user looged in");
      // print(username);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SafeArea(
              child: Column(
            children: [
              TextFormField(
                controller: econtroller,
                decoration: InputDecoration(
                    labelText: "enter your email",
                    hintText: ("example@gmail.com")),
              ),
              TextFormField(
                controller: pcontroller,
                decoration: InputDecoration(labelText: "enter your Password"),
              ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: login, child: Text('login')),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text("go to sign up"))
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
