import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_algoriza/cubit/cubit.dart';
import 'package:intl/intl.dart';
import 'package:todo_algoriza/screens/schedule_screen.dart';
import 'package:todo_algoriza/screens/schedule_screen.dart';
import 'package:todo_algoriza/screens/schedule_screen.dart';
import 'package:todo_algoriza/screens/schedule_screen.dart';
import 'package:todo_algoriza/shared/widgets/buildScheduleItem.dart';

import '../cubit/states.dart';
import '../shared/widgets/buildSchedules.dart';
//bool flagdate=false;
class schedule extends StatelessWidget {

 // DateTime _selectedDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return

     BlocConsumer<appCubit,appStates>(
          listener: (context, state) {},

        builder: (context,state) {
          appCubit cubit=appCubit.get(context);
         return 
           Scaffold(
              body:

              SingleChildScrollView(
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 45, 20, 10),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(icon: Icon( Icons.arrow_back_ios, size: 13,color: Colors.black),
                            onPressed: () {
                              Navigator.pop(context);
                            },),
                          SizedBox(width: 8,),
                          Text("Schedule", style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),),

                        ],),
                    ),
                    Container(
                      width: double.infinity, height: 1, color: Colors.grey[200],),
                    Container(
                      height: 100,

                      margin: EdgeInsets.only(top: 6, left: 20),

                      child: DatePicker(


                      DateTime.now(),
                       //cubit.selectedDate,
                        selectionColor: Colors.green,
                        height: 40,
                        deactivatedColor: Colors.grey,
                        //selectedTextColor: Colors.grey,
                        initialSelectedDate:appCubit.get(context).selectedDate ,
                        dayTextStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6), fontSize: 14),
                        monthTextStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6), fontSize: 14),
                        dateTextStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6), fontSize: 14),
                        onDateChange: (newDate) {
                         //  flagdate=true;


                          cubit.datechanged(newDate);


                        },


                      ),

                    ),
                    Container(
                      width: double.infinity, height: 1, color: Colors.grey[200],),

                    //            Container(
                    //              margin: EdgeInsets.all(10),
                    //              //padding: EdgeInsets.only(bottom: 29),
                    //              child: Column(
                    //                children: [
                    //                  Padding(
                    //                    padding: const EdgeInsets.only(bottom: 10,top: 10,right:10 ,left:10 ),
                    //                    child: Row(
                    //                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //
                    //                      children: [
                    //                        Text(DateFormat('EEEE').format(_selectedDate),style: TextStyle(fontWeight: FontWeight.bold),),
                    //                        Text(DateFormat('dd MMM, yyyy').format(_selectedDate),style: TextStyle(fontWeight:FontWeight.bold,color: Colors.grey,),)
                    //
                    //
                    //                      ],
                    //
                    //                    ),
                    //                  ),
                    //                  Container(
                    //                    margin: EdgeInsets.all(10),
                    //                    padding: EdgeInsets.all(10),
                    //                    height: 75,
                    //                   decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(16),
                    //                     color: Colors.red
                    //
                    //                   ),
                    //                    child:
                    //                    Padding(
                    //                      padding: EdgeInsets.all(5),
                    //                      child: Row(
                    //                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                        children: [
                    //                          Column(
                    //                            crossAxisAlignment: CrossAxisAlignment.start,
                    //                            children: [Text("9:00 AM",style:
                    //                            TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    //                             SizedBox(height: 5,),
                    //                              Text("Design team meeting",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)],),
                    //                          Checkbox(value:selected,
                    //                              onChanged: (vall){
                    //                            setState(() {
                    //                              selected=vall!;
                    //                            });
                    //
                    //                           },
                    //                            side: BorderSide(color: Colors.white),
                    //
                    //                            shape: RoundedRectangleBorder(
                    //                                borderRadius: BorderRadius.circular(10)),
                    //
                    //
                    //
                    //                              )
                    //
                    //
                    //
                    //                        ],
                    // ),
                    //                    ),
                    //
                    //                  )
                    //                ],
                    //              ),
                    //
                    //            ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 20, 15),
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          // if(  appCubit
                          //     .get(context)
                          //     .Alltasks.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(DateFormat('EEEE').format(appCubit.get(context).selectedDate),style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(DateFormat('dd MMM, yyyy').format(appCubit.get(context).selectedDate),style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black.withOpacity(0.5),),)


                            ],

                          ),
                          schedule_items(


                               tasks:

                              appCubit
                              .get(context)
                              .Alltasks
                                 ),
                        ],
                      ),
                    ),


                  ],


                ),
              ),
            );

        }

    );
  }
}
