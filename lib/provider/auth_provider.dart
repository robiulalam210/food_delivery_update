

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Utlis/utlis.dart';
import '../ui/auth_screen/login_screen.dart';
import '../ui/bottom_nav_controller.dart';

class AuthProvider with ChangeNotifier {
  bool _loding = false;

  bool get loding => _loding;

  setLoding(bool value) {
    _loding = value;
    notifyListeners();
  }

  // void auth_signup( email,  password,name,age, BuildContext context) async {
  //   setLoding(true);
  //   try {
  //     var auth = await FirebaseAuth.instance;
  //         auth.createUserWithEmailAndPassword(email: email, password: password)
  //         .then((value) {
  //
  //
  //       var currentUser = auth.currentUser;
  //
  //       setLoding(true);
  //       CollectionReference collectionRef =
  //       FirebaseFirestore.instance.collection("users-form-data");
  //       return collectionRef.doc(currentUser!.email).set({
  //         "name": name,
  //         "age": age,
  //         "email":email
  //       }).then((value) {
  //         setLoding(false);
  //         Utlis().toastMessage("Suessfully");
  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(builder: (context) => LoginScreen()),
  //                 (route) => false);
  //       }).onError((error, stackTrace) {
  //         setLoding(false);
  //         Utlis().toastMessage(error.toString());
  //       });
  //     }).onError((error, stackTrace) {
  //       setLoding(false);
  //       Utlis().toastMessage(error.toString());
  //     });
  //   } catch (e) {
  //     setLoding(false);
  //     Utlis().toastMessage(e.toString());
  //   }
  // }

  void auth_Login( email,  password,BuildContext context) async {
    setLoding(true);
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BottomNavController()), (route) => false);
      }).onError((error, stackTrace) {
        setLoding(false);
        Utlis().toastMessage(error.toString());
      });
    } catch (e) {
      setLoding(false);
      Utlis().toastMessage(e.toString());
    }
  }
  //
  // sendUserDataToDB(name, phone, dob, gender, age, BuildContext context) async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   var currentUser = _auth.currentUser;
  //
  //   setLoding(true);
  //   CollectionReference _collectionRef =
  //   FirebaseFirestore.instance.collection("users-form-data");
  //   return _collectionRef.doc(currentUser!.email).set({
  //     "name": name,
  //     "phone": phone,
  //     "dob": dob,
  //     "gender": gender,
  //     "age": age,
  //   }).then((value) {
  //     setLoding(false);
  //     Utlis().toastMessage("Suessfully");
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) => LoginScreen()),
  //             (route) => false);
  //   }).onError((error, stackTrace) {
  //     setLoding(false);
  //     Utlis().toastMessage(error.toString());
  //   });
  // }
}
