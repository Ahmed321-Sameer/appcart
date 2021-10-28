import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethod {
  Future<void> addData(data) async {
    FirebaseFirestore.instance.collection("Product").add(data).catchError((e) {
      return print(e);
    });
    return data;
  }
}
