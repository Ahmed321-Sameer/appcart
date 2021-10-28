import 'package:appcart/screens/Signout.dart';
import 'package:appcart/screens/additem.dart';
import 'package:appcart/screens/cart.dart';
import 'package:appcart/screens/login.dart';
import 'package:appcart/screens/mainscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final screens = [
    Main(),
    AddItem(),
    Cart(),
    Signout(),
  ];
//   Future<void> _getUSerName() async {
//     FirebaseFirestore.instance
//         .collection('Users')
//         .doc((await FirebaseAuth.instance.currentUser!).uid)
//         .get();
//         var email = user.email;
// var userName = user.displayName;
//   }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("App"),
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                Container(child: Column()),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.home),
                  title: const Text("Hoem"),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.person),
                  title: const Text("Account"),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text("Cart"),
                ),
                ListTile(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text("Cart"),
                ),
              ],
            ),
          ),
          // appBar: AppBar(
          //   title: Text("Cart App"),
          //   centerTitle: true,
          // ),
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.red[200],
              selectedFontSize: 22,
              unselectedFontSize: 15,
              showSelectedLabels: true,
              currentIndex: currentIndex,
              onTap: (index) => setState(() => currentIndex = index),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: "Add Product",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check),
                  label: "SignOut",
                ),
              ]),
        ),
      ),
    );
  }
}
