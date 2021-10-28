import 'dart:io';
import 'package:appcart/screens/home.dart';
import 'package:appcart/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'dart:math';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();

  String? downloadedUrl;
  var random = new Random();
  //final CrudMethod crudMethod = CrudMethod();
  String? url;
  void pickImage() async {
    String chlidref = random.nextInt(1000000).toString();
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);

    await FirebaseStorage.instance
        .ref("avit")
        .child("${chlidref}.jpg")
        .putFile(File(image!.path))
        .then((value) async {
      downloadedUrl = await value.ref.getDownloadURL();
      setState(() {
        url = downloadedUrl;
      });
      print("Image url " + downloadedUrl!);
    });
  }

  uloadtask() async {
    await FirebaseFirestore.instance.collection("new").doc().set({
      "Image": url,
      "Name": namecontroller.text.trim().toString(),
      "Price": pricecontroller.text.trim().toString(),
    });
    print("object");
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add Prouct"),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  GestureDetector(
                    onTap: () {
                      uloadtask();
                    },
                    child: Icon(
                      Icons.file_upload,
                    ),
                  )
                ])
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: url != null
                      ? Container(
                          height: 350,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              downloadedUrl!,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black54,
                          ),
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                        ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(children: [
                    TextFormField(
                      controller: namecontroller,
                      decoration: InputDecoration(hintText: "Product Name"),
                      // onChanged: (value) {
                      //   Name = value;
                      // },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: pricecontroller,
                      // onChanged: (value) {
                      //   Price = value;
                      // },
                      decoration: InputDecoration(hintText: "Product Price"),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
