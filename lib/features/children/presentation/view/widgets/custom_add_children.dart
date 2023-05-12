import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_cach/constant.dart';
import 'package:tab_cach/core/utils/style.dart';

import '../../../../../core/widgets/custom_text_form_faild.dart';


Future<void> showAlertDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,

    barrierDismissible: false,
    builder: (BuildContext context) {
      double heightScreen = MediaQuery.of(context).size.height;
      double widthScreen = MediaQuery.of(context).size.width;

      return AlertDialog(
        backgroundColor: kContainerColor,
        title:  Text('Add children', style: GoogleFonts.prompt(
            textStyle: Style.textStyle20,
            color: kBackGroundColor,
            fontWeight: FontWeight.w700),),
        content: SingleChildScrollView(
       //   padding: EdgeInsets.symmetric(horizontal: 300s),
          child: ListBody(
            children: [
              CustomTextFormFaild(
                hintText: "Name",
                obscureText: false,

              ),
              SizedBox(height: heightScreen*0.02,),
              CustomTextFormFaild(
                hintText: "Phone Number",
                obscureText: false,

              ),
              SizedBox(height: heightScreen*0.02,),
              CustomTextFormFaild(
                hintText: "Password",
                obscureText: false,

              ),

            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}