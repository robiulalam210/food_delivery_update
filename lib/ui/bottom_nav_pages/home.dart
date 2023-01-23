import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../const/AppColors.dart';
import '../../main.dart';
import '../product_details_screen.dart';
import '../search_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  List _categorys = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["img-path"],
        );
        print(qn.docs[i]["img-path"]);
      }
    });

    return qn.docs;
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });

    return qn.docs;
  }

  fetchPCategory() async {
    QuerySnapshot qn = await _firestoreInstance.collection("category").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _categorys.add({
          "product-name": qn.docs[i]["product-name"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });

    return qn.docs;
  }

  int _counter = 0;

  @override
  void initState() {
    super.initState();

    fetchCarouselImages();
    fetchProducts();
    fetchPCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(left: 14, right: 14),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: "Search products here",
                    hintStyle: TextStyle(fontSize: 15),
                  ),
                  onTap: () => Navigator.push(context,
                      CupertinoPageRoute(builder: (_) => SearchScreen())),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              AspectRatio(
                aspectRatio: 4.2,
                child: CarouselSlider(
                    items: _carouselImages
                        .map((item) => Padding(
                              padding: EdgeInsets.only(left: 3, right: 3),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(item),
                                        fit: BoxFit.cover)),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (val, carouselPageChangedReason) {
                          setState(() {
                            _dotPosition = val;
                          });
                        })),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              DotsIndicator(
                dotsCount:
                    _carouselImages.length == 0 ? 1 : _carouselImages.length,
                position: _dotPosition.toDouble(),
                decorator: DotsDecorator(
                  activeColor: AppColors.deep_orange,
                  color: AppColors.deep_orange.withOpacity(0.5),
                  spacing: EdgeInsets.all(2),
                  activeSize: Size(8, 8),
                  size: Size(6, 6),
                ),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     TextButton(
              //       onPressed: () {},
              //       child: Text("Category", style: TextStyle(fontSize: 14,color:AppColors.deep_orange )),
              //     ),
              //     TextButton(
              //       onPressed: () {},
              //       child: Text("See All", style: TextStyle(fontSize: 14,color: AppColors.deep_orange)),
              //     ),
              //   ],
              // ),
              //
              // //Category,,,,,,,,,,,,,,,,,
              // Container(
              //   height: 90,
              //   width: double.infinity,
              //   child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: _categorys.length,
              //       itemBuilder: (contex, index) {
              //         return Container(
              //           width: 120,
              //           height: 90,
              //           child: GestureDetector(
              //             // onTap: () => Navigator.push(
              //             //     context,
              //             //     MaterialPageRoute(
              //             //         builder: (context) =>
              //             //             ProductDetails(_products[index]))),
              //             child: Card(
              //               elevation: 3,
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Expanded(
              //                     child: ClipRRect(
              //                         borderRadius: BorderRadius.circular(8),
              //                         child: Container(
              //                             width: double.infinity,
              //                             color: Colors.yellow,
              //                             child: Image.network(
              //                               _categorys[index]["product-img"],
              //                               fit: BoxFit.cover,
              //                             ))),
              //                   ),
              //                   SizedBox(
              //                     height:
              //                         MediaQuery.of(context).size.height * 0.01,
              //                   ),
              //                   Text(
              //                     " ${_categorys[index]["product-name"]}",
              //                     maxLines: 1,style: TextStyle(fontSize: 14),
              //                   ),
              //                   SizedBox(
              //                     height:
              //                         MediaQuery.of(context).size.height * 0.01,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         );
              //       }),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text("Prodacts",
                        style: TextStyle(
                            fontSize: 14, color: AppColors.deep_orange)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("See All",
                        style: TextStyle(
                            fontSize: 14, color: AppColors.deep_orange)),
                  ),
                ],
              ),

              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: _products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1),
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetails(_products[index]))),
                        child: Card(
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                  aspectRatio: 2,
                                  child: Container(
                                      color: Colors.yellow,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          _products[index]["product-img"],
                                          fit: BoxFit.cover,
                                        ),
                                      ))),

                            Padding(
                              padding:  EdgeInsets.only(left: 7),
                              child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                    Text(
                                      "Product: ${_products[index]["product-name"]}",
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.01,
                                    ),
                                    Text(
                                      "description: ${_products[index]["product-description"]}",
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.01,
                                    ),
                                    Text(
                                      "৳ ${_products[index]["product-price"].toString()}",
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                            ),

                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
