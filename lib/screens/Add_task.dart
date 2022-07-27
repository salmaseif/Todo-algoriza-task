

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_algoriza/screens/schedule_screen.dart';
import '../shared/constants/local notifications/notification_services.dart';
import 'package:todo_algoriza/shared/widgets/mybutton.dart';
import 'package:todo_algoriza/shared/widgets/myfield.dart';
import 'package:todo_algoriza/cubit/cubit.dart';

import '../cubit/states.dart';

class Add_task extends StatefulWidget {
  @override
  _Add_taskState createState() => _Add_taskState();
}

class _Add_taskState extends State<Add_task> {

  final _formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  // var titleController = TextEditingController();
  // var dateController = TextEditingController();
  // var starttimeController = TextEditingController();
  // var endtimeController = TextEditingController();
  // var repeatController = TextEditingController();
  // var  remindController = TextEditingController();
//  DateTime selecteddate=DateTime.now();
//   bool flag = false;
//   bool flagR = false;

  // int selected_remind = 5;
  List<int> remindlist = [5, 10, 15, 20];
  // String _selectedRepeat = 'None';
  // int selectedcolor=0;
  int colorindex=0;
  List<String> repeatList = ['None', 'Daily', 'Weekely', 'Monthly'];
  String ss = "onee";
  late var notifyhelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // flag = false;
    // flagR = false;
     notifyhelper= notifyHelper();
     notifyhelper.requestIOSPermissions();
     notifyhelper.initializeNotification();


  }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<appCubit,appStates>(
        listener: (BuildContext context,appStates state){


        },
        builder: (BuildContext context,appStates state) {
          appCubit cubit = appCubit.get(context);
          return Scaffold(
            // key: scaffoldKey,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 45, 20, 10),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(icon: Icon(Icons.arrow_back_ios, size: 13,color: Colors.black),

                          onPressed: () {
                          appCubit.get(context).clear();
                            //  notifyhelper.displayNotification(
                            // title: "go back", body: "jhjh");
                          //  notifyhelper.scheduleNotification2();
                            Navigator.pop(context);
                          },),
                        SizedBox(width: 8,),
                        Text("Add task", style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),),

                      ],),
                  ),
                  // Container(
                  //   width: double.infinity,
                  //  // height: 55,
                  //   decoration: BoxDecoration(
                  //     border: Border(
                  //       bottom: BorderSide(color: Colors.grey.shade200, width: 1,),
                  //     ),
                  //   ),
                  // ),
                  Container(width: double.infinity,
                    height: 1,
                    color: Colors.grey[200],),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        myfield
                          (
                          title: "Title",
                          validatenote: 'title can not be empty',
                          controller: appCubit.get(context).titleController,
                          hint: "Design team meeting",
                          fun: () {},
                          type: TextInputType.text,
                        ),

                        myfield(
                          title: "Deadline",
                          validatenote: 'Deadline can not be empty',
                          controller: appCubit.get(context).dateController,
                          hint: "2021-02-8",
                          widget: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.grey,
                          ),
                          fun: () async {
                            final date = await showDatePicker(

                              context: context,
                              initialDate: appCubit.get(context).selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse("2023-05-03"),
                            );
                            if (date != null) {
                              appCubit.get(context).dateController.text =
                                  DateFormat('yyyy-MM-dd').format(date);
                            appCubit.get(context).changedate(date);

                            }
                          },
                          type: TextInputType.datetime,
                        ),

                        Row(
                          children: [

                            Expanded(
                              child: myfield(
                                title: "Start time",
                                validatenote: 'start time can not be empty',
                                controller: appCubit.get(context).starttimeController,
                                hint: "11:00 Am",
                                widget: const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.grey,
                                ),
                                fun: () async {
                                  TimeOfDay? time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now());
                                  if (time != null) {
                                    appCubit.get(context).starttimeController.text =

                                        time.format(context).toString();
                                  }
                                },
                                type: TextInputType.datetime,
                              ),
                            ),

                            Expanded(
                              child: myfield(

                                title: "End time",
                                validatenote: 'End time can not be empty',
                                controller: appCubit.get(context).endtimeController,
                                hint: "14:00 Pm",
                                widget: const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.grey,
                                ),
                                fun: () async {
                                  TimeOfDay? time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 30))));
                                  if (time != null) {
                                    appCubit.get(context).endtimeController.text =
                                        time.format(context).toString();
                                  }
                                },
                                type: TextInputType.datetime,
                              ),
                            ),

                          ],
                        ),


                        myfield(
                          readonly: true,
                          title: "Remind",
                          validatenote: 'remind can not be empty',
                          controller: appCubit.get(context).remindController,
                          hint: "${appCubit.get(context).selected_remind} minutes early",
                          widget: DropdownButton(
                            underline: Container(),
                            items: remindlist
                                .map<DropdownMenuItem<String>>(
                                    (value) =>
                                    DropdownMenuItem<String>(
                                        value: value.toString(),
                                        child: Text(
                                          '$value',
                                          style: const TextStyle(color: Colors.black),
                                        )))
                                .toList(),
                            icon: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.grey,
                              ),
                            ),
                            elevation: 4,
                            onChanged: (String? newvalue) {
                              String? hh = Text(
                                newvalue!,
                                style: TextStyle(color: Colors.black),
                              ).data;


                              appCubit.get(context).remindController.text=newvalue+" minutes early";
                                // selected_remind = int.parse(hh!);
                                 appCubit.get(context).remindchange(int.parse(hh!));

                            },
                          ),
                          widgetStyle: appCubit.get(context).flag == false
                              ? TextStyle(color: Colors.grey)
                              : TextStyle(color: Colors.black),


                        ),

                        myfield(
                          readonly: true,
                          title: "Repeat",
                          validatenote: 'repeat can not be empty',
                          controller: appCubit.get(context).repeatController,
                          hint: "${appCubit.get(context).selectedRepeat} ",
                          widget: DropdownButton(

                           // value: _selectedRepeat,
                            underline: Container(),
                            items: repeatList
                                .map<DropdownMenuItem<String>>(
                                    (value) =>
                                    DropdownMenuItem<String>(

                                        value: value.toString(),
                                        child: Text(
                                          '$value',
                                          style: TextStyle(color: Colors.black),
                                        )))
                                .toList(),
                            icon: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.grey,
                              ),
                            ),
                            elevation: 4,

                            onChanged: (String? newvalue) {

                              String? hh = Text(
                                newvalue!,
                                style: TextStyle(color: Colors.black),
                              ).data;


                              appCubit.get(context).repeatController.text=newvalue;
                              appCubit.get(context).repeatchange(hh!);

                            },
                          ),
                          widgetStyle: appCubit.get(context).flagp == false
                              ? TextStyle(color: Colors.grey)
                              : TextStyle(color: Colors.black),


                        ),

                        // Text("Title",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold ),),
                        // SizedBox(height: 7,),
                        // TextFormField(
                        //   controller: titleController,
                        //   keyboardType: TextInputType.text,
                        //   validator: (String? vv) {
                        //     if (vv == null || vv.isEmpty) {
                        //       return 'title can not be empty';
                        //     }
                        //     return null;
                        //   },
                        //   style: TextStyle(color: Colors.black),
                        //   decoration:  InputDecoration(
                        //  // labelText: "Design team meeting",
                        //
                        //   fillColor: Colors.grey[150],
                        //   hintStyle: TextStyle( color: Colors.grey),
                        //   hintText: "Design team meeting",
                        //  // hoverColor: Colors.red,
                        //     filled: true,
                        //     enabledBorder: OutlineInputBorder(
                        //
                        //         borderSide: new BorderSide(
                        //
                        //       color: Colors.transparent,
                        //       width: 1.0,
                        //     ) ,
                        //     borderRadius: BorderRadius.circular(10,),
                        //   )),
                        // ),
                        // SizedBox(height: 15,),
                        // Text("Deadline",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold ),),
                        // SizedBox(height: 7,),
                        // TextFormField(
                        //
                        //   controller: dateController,
                        //   keyboardType: TextInputType.datetime,
                        //   validator: (String? vv) {
                        //     if (vv == null || vv.isEmpty) {
                        //       return 'title can not be empty';
                        //     }
                        //     return null;
                        //   },
                        //   style: TextStyle(color: Colors.black),
                        //   onTap: () async {
                        //     final date=await showDatePicker(
                        //       context: context,
                        //       initialDate: DateTime.now(),
                        //       firstDate:DateTime.now() ,
                        //       lastDate: DateTime.parse("2023-05-03"),
                        //     );
                        //     if (date != null) {
                        //
                        //      dateController.text = DateFormat('yyyy-MM-dd').format(date);
                        //
                        //     }
                        //   },
                        //   decoration:  InputDecoration(
                        //     // labelText: "Design team meeting",
                        //        suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,),
                        //       fillColor: Colors.grey[150],
                        //       hintStyle: TextStyle( color: Colors.grey),
                        //       hintText: "2021-02-28",
                        //       // hoverColor: Colors.red,
                        //       filled: true,
                        //       enabledBorder: OutlineInputBorder(
                        //
                        //         borderSide: const BorderSide(
                        //
                        //           color: Colors.transparent,
                        //           width: 1.0,
                        //         ) ,
                        //         borderRadius: BorderRadius.circular(10,),
                        //       )),
                        // ),
                        // SizedBox(
                        //   height: 35,
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Start time",
                        //       style: TextStyle(
                        //           color: Colors.black, fontWeight: FontWeight.bold),
                        //     ),
                        //     SizedBox(
                        //       width: 100,
                        //     ),
                        //     Text(
                        //       "End time",
                        //       style: TextStyle(
                        //           color: Colors.black, fontWeight: FontWeight.bold),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 7,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: TextFormField(
                        //         controller: starttimeController,
                        //         keyboardType: TextInputType.datetime,
                        //         validator: (String? vv) {
                        //           if (vv == null || vv.isEmpty) {
                        //             return 'start time can not be empty';
                        //           }
                        //           return null;
                        //         },
                        //         style: TextStyle(color: Colors.black),
                        //         onTap: () async {
                        //           TimeOfDay? time = await showTimePicker(
                        //               context: context,
                        //               initialTime: TimeOfDay.now());
                        //           if (time != null) {
                        //             starttimeController.text =
                        //                 time.format(context).toString();
                        //           }
                        //         },
                        //         decoration: InputDecoration(
                        //             // labelText: "Design team meeting",
                        //             suffixIcon: Icon(Icons.access_time),
                        //             fillColor: Colors.grey[150],
                        //             hintStyle: TextStyle(color: Colors.grey),
                        //             hintText: "11:00 Am",
                        //             // hoverColor: Colors.red,
                        //             filled: true,
                        //             enabledBorder: OutlineInputBorder(
                        //               borderSide: const BorderSide(
                        //                 color: Colors.transparent,
                        //                 width: 1.0,
                        //               ),
                        //               borderRadius: BorderRadius.circular(
                        //                 10,
                        //               ),
                        //             )),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 15,
                        //     ),
                        //     Expanded(
                        //       child: TextFormField(
                        //         controller: endtimeController,
                        //         keyboardType: TextInputType.datetime,
                        //         validator: (String? vv) {
                        //           if (vv == null || vv.isEmpty) {
                        //             return 'end time can not be empty';
                        //           }
                        //           return null;
                        //         },
                        //         style: TextStyle(color: Colors.black),
                        //         onTap: () async {
                        //           TimeOfDay? time = await showTimePicker(
                        //               context: context,
                        //               initialTime: TimeOfDay.now());
                        //           if (time != null) {
                        //             endtimeController.text =
                        //                 time.format(context).toString();
                        //           }
                        //         },
                        //         decoration: InputDecoration(
                        //             // labelText: "Design team meeting",
                        //             suffixIcon: Icon(Icons.access_time),
                        //             fillColor: Colors.grey[150],
                        //             hintStyle: TextStyle(color: Colors.grey),
                        //             hintText: "14:00 AM",
                        //             // hoverColor: Colors.red,
                        //             filled: true,
                        //             enabledBorder: OutlineInputBorder(
                        //               borderSide: const BorderSide(
                        //                 color: Colors.transparent,
                        //                 width: 1.0,
                        //               ),
                        //               borderRadius: BorderRadius.circular(
                        //                 10,
                        //               ),
                        //             )),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // Text(
                        //   "Remind",
                        //   style: TextStyle(
                        //       color: Colors.black, fontWeight: FontWeight.bold),
                        // ),
                        // SizedBox(
                        //   height: 7,
                        // ),
                        // TextFormField(
                        //   controller: dateController,
                        //   keyboardType: TextInputType.datetime,
                        //   validator: (String? vv) {
                        //     if (vv == null || vv.isEmpty) {
                        //       return 'remind cannot be empty';
                        //     }
                        //     return null;
                        //   },
                        //   style: TextStyle(color: Colors.black),
                        //   decoration: InputDecoration(
                        //       // labelText: "Design team meeting",
                        //       suffixIcon: DropdownButton(
                        //         underline: Container(),
                        //         items: remindlist
                        //             .map<DropdownMenuItem<String>>(
                        //                 (value) => DropdownMenuItem<String>(
                        //                     value: value.toString(),
                        //                     child: Text(
                        //                       '$value',
                        //                       style: TextStyle(color: Colors.black),
                        //                     )))
                        //             .toList(),
                        //         icon: Padding(
                        //           padding: const EdgeInsets.all(15.0),
                        //           child: Icon(
                        //             Icons.keyboard_arrow_down_outlined,
                        //             color: Colors.grey,
                        //           ),
                        //         ),
                        //         elevation: 4,
                        //         onChanged: (String? newvalue) {
                        //           String? hh = Text(
                        //             newvalue!,
                        //             style: TextStyle(color: Colors.black),
                        //           ).data;
                        //           flag = true;
                        //           setState(() {
                        //             selected_remind = int.parse(hh!);
                        //           });
                        //         },
                        //       ),
                        //       fillColor: Colors.grey[150],
                        //       hintStyle: flag == false
                        //           ? TextStyle(color: Colors.grey)
                        //           : TextStyle(color: Colors.black),
                        //       hintText: "$selected_remind minutes early",
                        //       // hoverColor: Colors.red,
                        //       filled: true,
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: const BorderSide(
                        //           color: Colors.transparent,
                        //           width: 1.0,
                        //         ),
                        //         borderRadius: BorderRadius.circular(
                        //           10,
                        //         ),
                        //       )),
                        // ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        //
                        // Text(
                        //   "Repeat",
                        //   style: TextStyle(
                        //       color: Colors.black, fontWeight: FontWeight.bold),
                        // ),
                        // SizedBox(
                        //   height: 7,
                        // ),
                        // TextFormField(
                        //   showCursor: false,
                        //   readOnly: true,
                        //   validator: (String? vv) {
                        //     if (vv == null || vv.isEmpty) {
                        //       return 'remind cannot be empty';
                        //     }
                        //     return null;
                        //   },
                        //   style: TextStyle(color: Colors.black),
                        //   decoration: InputDecoration(
                        //       // labelText: "Design team meeting",
                        //       suffixIcon: DropdownButton(
                        //         underline: Container(),
                        //         items: repeatList
                        //             .map<DropdownMenuItem<String>>(
                        //                 (value) => DropdownMenuItem<String>(
                        //                     value: value.toString(),
                        //                     child: Text(
                        //                       '$value',
                        //                       style: TextStyle(color: Colors.black),
                        //                     )))
                        //             .toList(),
                        //         icon: Padding(
                        //           padding: const EdgeInsets.all(15.0),
                        //           child: Icon(
                        //             Icons.keyboard_arrow_down_outlined,
                        //             color: Colors.grey,
                        //           ),
                        //         ),
                        //         elevation: 4,
                        //         onChanged: (String? newvalue) {
                        //           String? hh = Text(
                        //             newvalue!,
                        //             style: TextStyle(color: Colors.black),
                        //           ).data;
                        //           flagR = true;
                        //           setState(() {
                        //             _selectedRepeat = hh!;
                        //           });
                        //         },
                        //       ),
                        //       fillColor: Colors.grey[150],
                        //       hintStyle: flagR == false
                        //           ? TextStyle(color: Colors.grey)
                        //           : TextStyle(color: Colors.black),
                        //       hintText: "$_selectedRepeat ",
                        //       // hoverColor: Colors.red,
                        //       filled: true,
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: const BorderSide(
                        //           color: Colors.transparent,
                        //           width: 1.0,
                        //         ),
                        //         borderRadius: BorderRadius.circular(
                        //           10,
                        //         ),
                        //       )),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),

                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 20,bottom: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text("Color",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                  ),

                                  Wrap(
                                      children: List.generate(3, (index) =>

                                          GestureDetector(
                                            onTap: (){

                                                 appCubit.get(context).colorChanged(index);



                                            },
                                            child:  Container(
                                              padding: EdgeInsets.only(right: 5),
                                              child: CircleAvatar(

                                                radius: 17,
                                                child:appCubit.get(context).selectedcolor==index? Icon(Icons.check, color: Colors.white,):null,
                                                backgroundColor: index==0?Colors.blueAccent
                                                :index==1?Colors.red:
                                                Colors.yellow,
                                              ),
                                            ),
                                          ),



                                      )
                                  )
                           ],),
                              ),
                            ),
                            
                            Expanded(
                              child: mybutton(
                                title: "create a task",
                                vv: () {
                                  // appCubit.get(context).Alltasks;

                                  if (_formKey.currentState!.validate()) {
                                    print("llllllllllllllllllllllllllllllllll");
                                    var hour= appCubit.get(context).starttimeController.text.split(':')[0];
                                    var minutes=appCubit.get(context).starttimeController.text.split(':')[1];
                                    var date=DateFormat.jm().parse(appCubit.get(context).starttimeController.text);
                                    var mytime=DateFormat("HH:mm ").format(date);

                                    cubit.insertToDB(appCubit.get(context).titleController.text, appCubit.get(context).starttimeController.text,
                                        appCubit.get(context). endtimeController.text, appCubit.get(context).dateController.text,appCubit.get(context).selectedRepeat , appCubit.get(context).selected_remind, appCubit.get(context).selectedcolor);
                                    print("${appCubit.get(context).selected_remind} selected remind");
                                   //notifyhelper.scheduleNotification2();
                                    notifyhelper.scheduleNotification(int.parse(mytime.toString().split(':')[0]),
                                        int.parse(mytime.toString().split(':')[1]),appCubit.get(context).selected_remind,
                                        appCubit.get(context).selectedRepeat,appCubit.get(context).dateController.text,appCubit.get(context).titleController.text);
                                    appCubit.get(context).clear();
                                    Navigator.pushAndRemoveUntil(
                                      context,

                                       MaterialPageRoute(builder: (BuildContext context) {
                                      return schedule();
                                    }),
                                         (route) => true,

                                    );
                                  }
                                  // print("hellllllllllllllllllllllllllllllllll00000");
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(builder: (BuildContext context) {
                                  //       return schedule();
                                  //     }));
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

    );

  }


}



