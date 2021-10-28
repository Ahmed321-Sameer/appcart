import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class subcollection extends StatefulWidget {
  String docid;
  subcollection({Key? key, required this.docid}) : super(key: key);

  @override
  _subcollectionState createState() => _subcollectionState();
}

class _subcollectionState extends State<subcollection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("productone")
              .doc(widget.docid)
              .collection("products")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final curdoc = snapshot.data!.docs[index];
                return Container(
                  color: Colors.black,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
