import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_algoriza/cubit/cubit.dart';
import 'package:todo_algoriza/shared/widgets/buildScheduleItem.dart';
import 'package:intl/intl.dart';

class schedule_items extends StatefulWidget {
  List<Map>? tasks;
  schedule_items({
    Key? key,
    required this.tasks,
  }) : super(key: key);
  @override
  _schedule_itemsState createState() => _schedule_itemsState();
}

class _schedule_itemsState extends State<schedule_items> {
  @override
  Widget build(BuildContext context) {
    print("from schudeleeeee");
    print("${widget.tasks}");
    return ConditionalBuilder(
        condition: widget.tasks?.length != 0,
        fallback: (context) => Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 250,
                margin: EdgeInsets.only(top: 60),
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
        builder: (context) => ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,

            // scrollDirection: Axis.vertical,
            itemCount: widget.tasks?.length,
            itemBuilder: (BuildContext context, int index) {
              String datee = DateFormat('yyyy-MM-dd')
                  .format(appCubit.get(context).selectedDate);
              if (widget.tasks![index]['date'] == datee ||
                  widget.tasks![index]['repeat'] == 'Daily' ||
                  (widget.tasks![index]['repeat'] == 'Weekely' &&
                      appCubit
                                  .get(context)
                                  .selectedDate
                                  .difference(DateFormat('yyyy-MM-dd')
                                      .parse(widget.tasks![index]['date']))
                                  .inDays %
                              7 ==
                          0) ||
                  (widget.tasks![index]['repeat'] == 'Monthly' &&
                      DateFormat('yyyy-MM-dd')
                              .parse(widget.tasks![index]['date'])
                              .day ==
                          appCubit.get(context).selectedDate.day)) {
                return schedule_item(
                  model: widget.tasks![index],
                  context: context,
                  index: index,
                );
              } else {
                return Container();
              }
            }));
  }
}
