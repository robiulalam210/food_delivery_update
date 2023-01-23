import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/admin/dalivery/product_details_screen.dart';

import '../../../ui/product_details_screen.dart';
import 'dalivery_man_add.dart';

class DalevaryHomePage extends StatefulWidget {
  const DalevaryHomePage({Key? key}) : super(key: key);

  @override
  State<DalevaryHomePage> createState() => _DalevaryHomePageState();
}

class _DalevaryHomePageState extends State<DalevaryHomePage> {

  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("Dalivery").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "name": qn.docs[i]["name"],
          "email": qn.docs[i]["email"],
          "phone": qn.docs[i]["phone"],
          "profilePic": qn.docs[i]["profilePic"],
        });
      }
    });

    return qn.docs;
  }
  @override
  void initState() {
    super.initState();

    fetchProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dalivery Man Information"),),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DaliveryManAdd()));
      },child: Icon(Icons.add),),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(children: [
        GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: _products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, childAspectRatio: 5),
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DaliveryDetails(_products[index]))),
                child: Card(
                  elevation: 3,
                  child: ListTile(
                    leading:  CircleAvatar(
                      maxRadius: 40,
                      backgroundImage: NetworkImage(
                        _products[index]["profilePic"],

                      ),
                    ),

                    title: Text(
                      "Name: ${_products[index]["name"]}",
                      maxLines: 1,
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      "Number: ${_products[index]["phone"]} Gmail: ${_products[index]["email"]}",
                      maxLines: 2,
                    ),
                  ),
                ),
              );
            }),
      ],),),
    );
  }
}
