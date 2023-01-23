import 'package:flutter/material.dart';
import '../const/AppColors.dart';
import 'SliderImageShow_item.dart';
import 'card_item.dart';
import 'dalivery/homepage_dalevary.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page"),
        centerTitle: true,
        backgroundColor: AppColors.deep_orange,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminSliderImageItem()));
                  },
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.deep_orange,
                      ),
                      height: 200,
                      child: Center(
                        child: Text(
                          "Admin Slider",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminItem()));
                  },
                  child: Card(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: AppColors.deep_orange,
                        ),
                        height: 200,
                        child: Center(
                            child: Text("Admin Podact",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)))),
                  ),
                )),
              ],
            ),
            Row(
              children: [

                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DalevaryHomePage()));
                  },
                  child: Card(
                    child: Container(
                        height: 200, child: Center(child: Text("Dalivery"))),
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
