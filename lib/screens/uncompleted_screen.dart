import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_algoriza/cubit/cubit.dart';
import 'package:todo_algoriza/shared/widgets/buildtaskitem.dart';

import '../cubit/states.dart';
import '../shared/widgets/buildtasks.dart';
class uncompleted_screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<appCubit,appStates>(
        listener: (context, state) {},
        builder:(context,state) {
          return
            buildtasks(tasks: appCubit.get(context).uncompletedtasks);
        });
  }
}
