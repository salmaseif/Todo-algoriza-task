import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:todo_algoriza/cubit/cubit.dart';
class buildTaskitem extends StatefulWidget {
  Map? model;
  bool value=false;
  BuildContext? context;
  int? index;
  buildTaskitem(
      {Key? key,

        required this.model,
        required this.context,
        required this.index
      })
      : super(key: key);
  @override
  _buildTaskitemState createState() => _buildTaskitemState();
}

class _buildTaskitemState extends State<buildTaskitem> {
  @override
  void initState() {
    print("frommmm build itemmm");

    print(widget.model);
    print(appCubit.get(context).Alltasks[0]);
    //print(widget.model);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction){appCubit.get(context).deleteData(widget.model!['id']);},
      background:buildSwipeActionRight() ,
      key: Key((widget.model!['id'])!.toString()),
      child: ListTile(
        leading: Transform.scale(
          scale: 1.3,
          child: Checkbox(
            activeColor: Colors.deepOrange,
            side: BorderSide(color: Colors.deepOrange),

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)),
            value: widget.model!['iscomp']==1,//appCubit.get(context).isChecked![widget.index!],
            onChanged: (value){
              int i;
             if( value==true)
               {i=1;}
             else
               {
                 i=0;
               }

              appCubit.get(context).updateData(i, widget.model!['id']);
            },

          ),
        ),
        //minLeadingWidth: 2,

        title: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[ Align(child: Text(widget.model!['title']),alignment: Alignment(-1.2, 0),),
          IconButton(color: Colors.red,icon:
        widget.model!['isfav']==0?
        Icon(Icons.favorite_border):
        Icon(Icons.favorite),
          onPressed: () {
            if(widget.model!['isfav']==0)

              appCubit.get(context).updateData2(1, widget.model!['id']);
            else
              appCubit.get(context).updateData2(0, widget.model!['id']);

          },),]),
        // subtitle: IconButton(color: Colors.red,icon:
        //                     widget.model!['isfav']==0?
        //                     Icon(Icons.favorite_border):
        //                     Icon(Icons.favorite),
        //   onPressed: () {
        //           if(widget.model!['isfav']==0)
        //
        //     appCubit.get(context).updateData2(1, widget.model!['id']);
        //           else
        //             appCubit.get(context).updateData2(0, widget.model!['id']);
        //
        //   },),

      ),
    );
  }
  Widget buildSwipeActionRight() => Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.symmetric(horizontal: 20),
    color: Colors.red,
    child: Icon(Icons.delete_forever, color: Colors.white, size: 32),
  );
}
