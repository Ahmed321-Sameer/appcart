import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        // color: Colors.black,
        height: 250,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Product2').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  // physics: ph,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DocumentSnapshot curdoc = snapshot.data!.docs[index];
                    return Container(
                      margin: EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 150,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
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
                                        width: 120,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.amber[300],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    FirebaseFirestore.instance
                                                        .collection("cart")
                                                        .doc()
                                                        .set(
                                                      {
                                                        "Image":
                                                            curdoc['Image'],
                                                        "Name": curdoc['Name'],
                                                        "Price":
                                                            curdoc['Price'],
                                                      },
                                                    );

                                                    print(curdoc["Name"]);
                                                  },
                                                  child: Text("Add to cart")),
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
      ),
    );
  }
}
