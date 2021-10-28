import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your cart"),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("cart")
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return Container(
                width: 400,
                child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    // physics: ph,
                    // scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DocumentSnapshot curdoc = snapshot.data!.docs[index];
                      return Container(
                        margin: EdgeInsets.only(left: 50, top: 10, right: 20),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 150,
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                curdoc["Image"],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  color: Colors.amber,
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(curdoc["Name"]),
                                            Text(curdoc["Price"]),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          //width: 150,
                                          color: Colors.amber[300],
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      FirebaseFirestore.instance
                                                          .collection("cart")
                                                          .doc(curdoc.id)
                                                          .delete();
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.amber[200],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          child: InkWell(
                                                            child: Text(
                                                                "Remove item"),
                                                          )),
                                                    )),
                                                Container(
                                                    width: 110,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.amber[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 45,
                                                          color: Colors.amber,
                                                          child: Material(
                                                            color: Colors
                                                                .transparent,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  if (count >
                                                                      1) {
                                                                    setState(
                                                                        () {
                                                                      count--;
                                                                    });
                                                                  }
                                                                },
                                                                child: Icon(Icons
                                                                    .remove)),
                                                          ),
                                                        ),
                                                        Text("$count"),
                                                        Container(
                                                          width: 45,
                                                          color: Colors.amber,
                                                          child: Material(
                                                            color: Colors
                                                                .transparent,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  if (count >
                                                                      0) {
                                                                    setState(
                                                                        () {
                                                                      count++;
                                                                    });
                                                                  }
                                                                },
                                                                child: Icon(
                                                                    Icons.add)),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ]),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              );
            },
          ),
        ));
  }
}
