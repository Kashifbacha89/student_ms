import 'package:flutter/material.dart';

class MyTextForm extends StatelessWidget {
   MyTextForm({Key? key,required this.hText,required this.lbText,required this.myController,required this.myValue}) : super(key: key);
  String hText,lbText,myController;
  var myValue;


  @override
  Widget build(BuildContext context) {
    return TextFormField(

      decoration: InputDecoration(
        hintText: hText,
        labelText: lbText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),

        )

      ),
      validator: (myValue){
        if(myValue==null||myValue.isNotEmpty){
          return 'Enter the value';
        }
        return null;
      },

    );
  }
}
