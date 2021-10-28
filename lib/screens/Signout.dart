import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signout extends StatelessWidget {
  const Signout({Key? key}) : super(key: key);
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        signOut();
      },
      child: Container(),
    );
  }
}
