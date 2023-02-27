import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const/AppColors.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users-cart-items")
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection("items")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Something is wrong"),
                    );
                  }

                  return ListView.builder(
                      itemCount: snapshot.data == null
                          ? 0
                          : snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];

                        return Column(
                          children: [
                            Card(
                              elevation: 5,
                              child: ListTile(
                                leading: CircleAvatar(backgroundImage:NetworkImage(_documentSnapshot['images'])),
                                title: Text(_documentSnapshot['name']),
                                subtitle: Text(
                                  "\$ ${_documentSnapshot['price']}  ${_documentSnapshot['address']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.deep_orange),
                                ),
                                trailing: GestureDetector(
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.deep_orange,
                                    child: Icon(Icons.remove_circle,color: Colors.white,),
                                  ),
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection("users-cart-items")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.email)
                                        .collection("items")
                                        .doc(_documentSnapshot.id)
                                        .delete();
                                  },
                                ),
                              ),
                            ),

                          ],
                        );
                      });
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}
