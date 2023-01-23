
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/ui/auth_screen/registration_screen.dart';
import 'package:provider/provider.dart';

import '../../const/AppColors.dart';
import '../../provider/auth_provider.dart';
import '../Utlis/utlis.dart';
import 'home_page_admin.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xff2A9C47),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height:  MediaQuery.of(context).size.height *0.22,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.light,
                        color: Colors.transparent,
                      ),
                    ),
                    Text(
                      "Admin Login ...",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
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
                          height: MediaQuery.of(context).size.height *0.04,
                        ),
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                              fontSize: 20, color:Color(0xff2A9C47)),
                        ),
                        SizedBox(
                          height:  MediaQuery.of(context).size.height *0.01,
                        ),
                        Text(
                          "Glad to see you back my apps.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFBBBBBB),
                          ),
                        ),
                        SizedBox(
                          height:  MediaQuery.of(context).size.height *0.03,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 50,
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
                              width: MediaQuery.of(context).size.width *0.03,
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,

                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: "**@gmail.com",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff2A9C47),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),


                        SizedBox(
                          height:  MediaQuery.of(context).size.height *0.06,
                        ),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              var email=_emailController.text.toString();
                              if(email=='admin@gmail.com'){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => AdminHomePage()));
                              }else{
                              Utlis().toastMessage("Not currect Admin");

                              }

                            },
                            child:
                                 Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff2A9C47),
                              elevation: 3,
                            ),
                          ),
                        ),
                        // elevated button


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
