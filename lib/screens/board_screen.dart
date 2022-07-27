import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/checkbox_list_tile/gf_checkbox_list_tile.dart';
import 'package:todo_algoriza/cubit/cubit.dart';
import 'package:todo_algoriza/screens/Add_task.dart';
import 'package:todo_algoriza/screens/All_screen.dart';
import 'package:todo_algoriza/screens/completed_screens.dart';
import 'package:todo_algoriza/screens/favorite_screen.dart';
import 'package:todo_algoriza/screens/uncompleted_screen.dart';
import 'package:todo_algoriza/shared/widgets/mybutton.dart';

import '../cubit/states.dart';
import 'schedule_screen.dart';

class Board extends StatefulWidget {
  Board({Key? key}) : super(key: key);
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List screens = [
    All_screen(),
    completed_screen(),
    uncompleted_screen(),
    favorite_screen(),
  ];
//bool val=false;
  @override
  void initState() {
    // TODO: implement initState
    _tabController = new TabController(length: 4, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appCubit, appStates>(
        listener: (BuildContext context, appStates) {},
        builder: (BuildContext context, appStates) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 45, 20, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Board",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.calendar_today_outlined,
                            size: 20,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (v) {
                              return schedule();
                            }));
                          },
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    //  padding: EdgeInsets.only(left: 25),
                    width: double.infinity,
                    height: 55,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        //This is for background color
                        color: Colors.white.withOpacity(0.0),

                        //This is for bottom border that is needed
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.shade200, width: 1)),
                      ),
                      child: TabBar(
                        // padding: EdgeInsets.only(left: 15,),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.black,
                        controller: _tabController,
                        labelPadding: EdgeInsets.all(15),
                        //padding:EdgeInsets.all(1) ,
                        isScrollable: true,
                        labelColor: Colors.black,
                        automaticIndicatorColorAdjustment: true,
                        unselectedLabelColor: Colors.grey[400],

                        tabs: const [
                          Tab(
                            text: "All",
                          ),
                          Tab(
                            text: "Completed",
                          ),
                          Tab(
                            text: "Uncompleted",
                          ),
                          Tab(
                            text: "Favorite",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(controller: _tabController, children: [
                      All_screen(),
                      completed_screen(),
                      uncompleted_screen(),
                      favorite_screen(),
                    ]),
                  ),
                  mybutton(
                    title: "Add a task",
                    vv: () {
                      Navigator.push(context, MaterialPageRoute(builder: (v) {
                        return Add_task();
                      }));
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
