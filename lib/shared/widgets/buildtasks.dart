import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


import 'package:todo_algoriza/cubit/cubit.dart';
import 'package:todo_algoriza/shared/widgets/buildtaskitem.dart';
class buildtasks extends StatefulWidget {
  List<Map> tasks;
  buildtasks(
      {Key? key,

        required this.tasks,

      })
      : super(key: key);
  @override
  _buildtasksState createState() => _buildtasksState();
}

class _buildtasksState extends State<buildtasks> {
  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //
    //   scrollDirection: Axis.vertical,
    //
    //   // scrollDirection: Axis.vertical,
    //   itemCount: 15,
    //   itemBuilder: (BuildContext context, int index)
    //   {
        return ConditionalBuilder(condition:  widget.tasks.length > 0,
        fallback:(context)=>Center(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 250,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: Image.asset('assets/img/Clipboard-empty.png'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: const <Widget>[
                        Text(
                          'No tasks',
                          style: TextStyle(
                            color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(height: 15),

                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  )
                ],
              ),
            ),
          ),
        ),
        builder:(context)=> ListView.builder(


          scrollDirection: Axis.vertical,

          // scrollDirection: Axis.vertical,
          itemCount:widget.tasks.length ,
          itemBuilder: (BuildContext context, int index)
          {
            print("7alooohaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");

            return buildTaskitem(model:widget.tasks[index] , context: context,index: index,);})
        );
  }
}
