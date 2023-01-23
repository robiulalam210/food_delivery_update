

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../const/AppColors.dart';
import '../../../ui/auth_screen/model/user.dart';
import 'homepage_dalevary.dart';


class DaliveryManAdd extends StatefulWidget {
  @override
  _DaliveryManAddState createState() => _DaliveryManAddState();
}

class _DaliveryManAddState extends State<DaliveryManAdd> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool loding = false;
  late File proimg;
  Future<String> _uploadProPic(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePic_Dalivery')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imageDwnUrl = await snapshot.ref.getDownloadURL();
    return imageDwnUrl;
  }

  void  pickImageProfile() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    Fluttertoast.showToast(msg: "IMAGE PICKED SUCCESSFULLY");
    final img = File(image!.path);
    proimg = img;
  }

  void SignUp(
      String name, String email,String phone, String password, File image) async {
    try {
      if (name.isNotEmpty &&
          email.isNotEmpty &&
          phone.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        //  _uploadProPic(image);
        String downloadUrl = await _uploadProPic(image);

        myUser user = myUser(
            name: name,
            email: email,

            uid: credential.user!.uid, phone:phone, profilePhoto: downloadUrl);

        await FirebaseFirestore.instance
            .collection('Dalivery')
            .doc(credential.user!.uid)
            .set(user.toJson());
        Fluttertoast.showToast(msg: "Sucessfully");
      } else {
        Fluttertoast.showToast(msg: "Sumting is worng");
      }
    } catch (e) {
      print("eeeeeeeeeeeee $e");
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.deep_orange,
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Text(
                          "Welcome Food Apps!",
                          style: TextStyle(
                              fontSize: 20, color:AppColors.deep_orange),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
      pickImageProfile();


                            },
                            child: Stack(
                              children: [
                                const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://st3.depositphotos.com/1767687/16607/v/450/depositphotos_166074422-stock-illustration-default-avatar-profile-icon-grey.jpg"),
                                  radius: 60,
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(50)),
                                        child: Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: Colors.black,
                                        )))
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 41,
                              decoration: BoxDecoration(
                                  color: AppColors.deep_orange,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width:MediaQuery.of(context).size.width * 0.03,
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: "full name",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.deep_orange,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 41,
                              decoration: BoxDecoration(
                                  color: AppColors.deep_orange,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width:MediaQuery.of(context).size.width * 0.03,
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: phoneController,
                                decoration: InputDecoration(
                                  hintText: "phone",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'Phone',
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.deep_orange,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 41,
                              decoration: BoxDecoration(
                                  color: AppColors.deep_orange,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width:MediaQuery.of(context).size.width * 0.03,
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: "......@gmail.com",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.deep_orange,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 41,
                              decoration: BoxDecoration(
                                  color: AppColors.deep_orange,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Expanded(
                              child: TextField(
                                controller: passwordController,
                                obscureText: _obscureText,
                                keyboardType: TextInputType.text,

                                decoration: InputDecoration(
                                  hintText: "password must be 6 character",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.deep_orange,
                                  ),
                                  suffixIcon: _obscureText == true
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = false;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            size: 20,
                                          ))
                                      : IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = true;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.visibility_off,
                                            size: 20,
                                          )),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        // elevated button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              var name = nameController.text.trim().toString();
                              var phone = phoneController.text.trim().toString();
                              var email = emailController.text.trim().toString();
                              var password =
                                  passwordController.text.trim().toString();
                              SignUp(name,email,phone,password,proimg);


                            },
                            child: loding==true
                                ? CircularProgressIndicator()
                                : Text(
                                    "Continue",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.deep_orange,
                              elevation: 3,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
