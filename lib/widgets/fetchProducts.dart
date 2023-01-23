import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/AppColors.dart';

Widget fetchData (String collectionName){
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .snapshots(),
    builder:
        (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: Text("Something is wrong"),
        );
      }

      return ListView.builder(
          itemCount:
          snapshot.data == null ? 0 : snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            DocumentSnapshot _documentSnapshot =
            snapshot.data!.docs[index];

            return Card(
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(backgroundImage:NetworkImage(_documentSnapshot['images'])),

                title: Text(_documentSnapshot['name'],  style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
                subtitle: Text(
                  "\৳ ${_documentSnapshot['price']}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                trailing: GestureDetector(
                  child: CircleAvatar(
                    maxRadius: 35,
                    backgroundColor: AppColors.deep_orange,
                    child: Icon(Icons.remove_circle,color: Colors.white,),
                  ),
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection(collectionName)
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .collection("items")
                        .doc(_documentSnapshot.id)
                        .delete();
                  },
                ),
              ),
            );
          });
    },
  );
}