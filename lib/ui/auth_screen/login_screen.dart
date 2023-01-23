
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/ui/auth_screen/registration_screen.dart';
import 'package:provider/provider.dart';

import '../../const/AppColors.dart';
import '../../provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;



  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<AuthProvider>(context);
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
                      "Login ...",
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
                          height:  MediaQuery.of(context).size.height *0.02,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 41,
                              decoration: BoxDecoration(
                                  color:Color(0xff2A9C47),
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
                              width:  MediaQuery.of(context).size.width *0.03,
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.text,

                                controller: _passwordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintText: "password must be 6 character",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff2A9C47),
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
                          height:  MediaQuery.of(context).size.height *0.06,
                        ),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              var email=_emailController.text.toString();
                              var password=_passwordController.text.toString();

                              authProvider.auth_Login(email, password,context);
                            },
                            child: authProvider.loding
                                ? CircularProgressIndicator()
                                : Text(
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

                        SizedBox(
                          height: MediaQuery.of(context).size.height *0.03,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFBBBBBB),
                              ),
                            ),
                            GestureDetector(
                              child:Text(
                                " Sign Up",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff2A9C47),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            RegistrationScreen()));
                              },
                            )
                          ],
                        )
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
