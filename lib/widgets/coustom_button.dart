import 'package:flutter/material.dart';

import '../const/AppColors.dart';

CoustomMaterialButton({required VoidCallback onpressed, required bool loading, required String data}) {
  return MaterialButton(
      onPressed: onpressed,
      minWidth: double.infinity,
      height: 45,
      elevation: 5,
      color:AppColors.deep_orange
    ,

      child: loading
          ? CircularProgressIndicator(
              color: Colors.orange,
            )
          : Text("$data",style: TextStyle(color: Colors.white),));
}
