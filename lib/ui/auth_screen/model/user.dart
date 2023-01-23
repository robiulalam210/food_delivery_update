import 'package:cloud_firestore/cloud_firestore.dart';

class myUser{
  String name;
  String profilePhoto;
  String email;
  String phone;
  String uid;

  myUser(
  {
   required this.name,
   required this.email,
   required this.phone,
   required this.profilePhoto,
   required this.uid
}
      );

  //App - Firebase(Map)
  Map<String , dynamic> toJson() => {
      "name" : name,
      "profilePic" : profilePhoto,
      "email" : email,
      "phone" : phone,
      "uid" : uid
    };


  //Firebase(Map) - App(User)
  static myUser fromSnap( DocumentSnapshot snap){

    var snapshot = snap.data() as Map<String , dynamic>;
    return myUser(
      email: snapshot['email'],
      phone: snapshot['phone'],
      profilePhoto: snapshot["profilePic"],
      uid: snapshot["uid"],
      name: snapshot["name"]
    );

  }

}