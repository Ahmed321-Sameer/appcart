import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewProduct extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<ViewProduct> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Product one"),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 10),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Product').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return Container(
                margin: EdgeInsets.only(left: 20),
                // width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot curdoc = snapshot.data!.docs[index];
                      return Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 200,
                                width: 200,
                                child: Image.network(curdoc["Image"]),
                              ),
                              Container(
                                child: Column(children: [
                                  Text(curdoc["Name"]),
                                  Text(curdoc["Price"]),
                                ]),
                              ),
                            ]),
                      );
                    }),
              );
            },
          ),
        ));
  }
}
