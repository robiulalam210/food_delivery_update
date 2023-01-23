import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../const/AppColors.dart';
import '../../provider/admin/admin_add_provider.dart';
import '../../widgets/coustom_button.dart';
import '../../widgets/textformfield.dart';

class AddPostItem extends StatefulWidget {
  const AddPostItem({Key? key}) : super(key: key);

  @override
  State<AddPostItem> createState() => _AddPostItemState();
}

class _AddPostItemState extends State<AddPostItem> {

  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerDiscreption = TextEditingController();
  TextEditingController _controllerPrice= TextEditingController();
@override
  void initState() {
    // TODO: implement initState
  _controllerTitle.clear();
  _controllerDiscreption.clear();
    super.initState();
  }
//  bool loading = false;
  final _key = GlobalKey<FormState>();

  final picker = ImagePicker();
  File? _images;
  XFile? _courseImages;

  Future getImageGallery() async {
    _courseImages = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (_courseImages != null) {
        _images = File(_courseImages!.path);
      } else {
        print("no images selected");
      }
    });
  }

  Future getCamraImage() async {
    _courseImages = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (_courseImages != null) {
        _images = File(_courseImages!.path);
      } else {
        print("no images selected");
      }
    });
  }

  dilogBox(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getCamraImage();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.camera),
                      title: Text("Camra"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImageGallery();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.image),
                      title: Text("Gallery"),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    final addProvider=Provider.of<AdminAddProvider>(context);

    return Scaffold(
      appBar: AppBar(     backgroundColor: AppColors.deep_orange,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  dilogBox(context);
                },
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 1,
                    child: _images != null
                        ? ClipRRect(
                        child: Image.file(
                          _images!.absolute,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ))
                        : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20)),
                      height: 100,
                      width: 100,
                      child: Icon(Icons.camera),
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Form(
                  key: _key,
                  child: Column(
                    children: [
                      CoustomTextFormField(
                          controller: _controllerTitle,
                          data_return: 'Enter Blog Title',
                          obsText: false,
                          icon: Icon(Icons.title),
                          hintText: 'Enter Title'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CoustomTextFormField(
                          controller: _controllerDiscreption,
                          data_return: 'Enter Discreption',
                          obsText: false,
                          icon: Icon(Icons.book_online),
                          hintText: 'Enter Discreption'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ), CoustomTextFormField(
                          controller: _controllerPrice,
                          data_return: 'Enter Price',
                          obsText: false,
                          icon: Icon(Icons.price_change),
                          hintText: 'Enter Price'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CoustomMaterialButton(
                          onpressed: ()async {
                            if (_key.currentState!.validate()){
                              setState(() {
                                addProvider.setLoding(true);
                               // loading = true;

                              });
                              FirebaseStorage storage = await FirebaseStorage.instance;
                              UploadTask uploadTask =
                              storage.ref("products").child(_courseImages!.name).putFile(_images!);
                              TaskSnapshot _snapshot = await uploadTask;
                              var imgUrl = await _snapshot.ref.getDownloadURL();
                              var price_text=_controllerPrice.text ;
                              double? price=double.tryParse(price_text);
                              addProvider.sendData(_controllerTitle.text, _controllerDiscreption.text, price, imgUrl, context);

                            }
                          }, loading: addProvider.loding, data: 'Add Data'),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // sendData() async {
  //   loading = true;
  //   FirebaseStorage storage = await FirebaseStorage.instance;
  //   UploadTask uploadTask =
  //   storage.ref("products").child(_courseImages!.name).putFile(_images!);
  //   TaskSnapshot _snapshot = await uploadTask;
  //   var imgUrl = await _snapshot.ref.getDownloadURL();
  //
  //
  //   await FirebaseFirestore.instance.collection("products")
  //       .add(({
  //     "product-name": _controllerTitle.text,
  //     "product-description": _controllerDiscreption.text,
  //     "product-price": _controllerPrice.text,
  //     "product-img": imgUrl
  //   }))
  //       .then((value) {
  //     Utlis().toastMessage("Sucessfull");
  //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AdminItem()), (route) => false);
  //     setState(() {
  //       loading = false;
  //     });
  //   }).onError((error, stackTrace) {
  //     Utlis().toastMessage(error.toString());
  //     setState(() {
  //       loading = false;
  //     });
  //   });
  // }

}
