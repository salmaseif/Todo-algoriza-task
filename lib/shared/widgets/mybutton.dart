import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mybutton extends StatelessWidget {
String title;
VoidCallback? vv;
 mybutton({
    Key? key,
    required this.title,
   this.vv
  }) : super(key: key);
    @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return  Container(

        padding: EdgeInsets.all(25),
        width: double.infinity,
        child: MaterialButton(
          height: 50,
          onPressed: vv,child: Text(title,style: TextStyle(color: Colors.white),),
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),

          ),
        )





    );
  }
}

