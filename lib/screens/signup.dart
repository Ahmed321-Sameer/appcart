import 'package:appcart/screens/home.dart';
import 'package:appcart/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController name = TextEditingController();

    final TextEditingController password = TextEditingController();

    void login() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      // // FirebaseFirestore db = FirebaseFirestore.instance;
      // final String email = econtroller.text.trim();
      // final String password = pcontroller.text.trim();
      try {
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: email.text.trim().toString(),
            password: password.text.trim());

        FirebaseFirestore.instance.collection("users").doc(user.user!.uid).set({
          "name": name,
          "email": email,
          "id": user.user!.uid,
        });
        print(email);
        Dialog(
          backgroundColor: Colors.amber,
          child: Text('user is registerd'),
        );
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
                controller: name,
                decoration: InputDecoration(
                  labelText: "enter Name",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                    labelText: "enter your email",
                    hintText: ("example@gmail.com")),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: password,
                decoration: InputDecoration(labelText: "enter your Password"),
              ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: login, child: Text('login')),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text("Already have account go to Login"))
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
