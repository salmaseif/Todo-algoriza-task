import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_algoriza/cubit/cubit.dart';

class schedule_item extends StatefulWidget {
  Map? model;
  BuildContext? context;
  int? index;
  schedule_item(
      {Key? key,

        required this.model,
        required this.context,
        required this.index
      })
      : super(key: key);
  @override
  _schedule_itemState createState() => _schedule_itemState();
}

class _schedule_itemState extends State<schedule_item> {
  bool selected=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 17),
      //padding: EdgeInsets.only(bottom: 29),
      child: Column(
        children: [

          Container(
           // margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            height: 75,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: widget.model!['color']==0?Colors.blueAccent:widget.model!['color']==1?Colors.red:
                Colors.yellow,

            ),
            child:
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(widget.model!['starttime'],style:
                    TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text(widget.model!['title'],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)],),
                  Checkbox(value:widget.model!['iscomp']==1,
                    onChanged: (vall){
                      int i;
                      if( vall==true)
                      {i=1;}
                      else
                      {
                        i=0;
                      }

                      appCubit.get(context).updateData(i, widget.model!['id']);
                    },
                    side: BorderSide(color: Colors.white),

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),



                  )



                ],
              ),
            ),

          )
        ],
      ),

    );
  }
}
