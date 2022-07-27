import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/board_screen.dart';
import 'package:todo_algoriza/cubit/cubit.dart';
import 'package:todo_algoriza/cubit/states.dart';
import 'shared/constants/local notifications/notification_services.dart';
import 'shared/constants/BlocProvider/constants.dart';

void main() async {


  BlocOverrides.runZoned(
        () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
  WidgetsFlutterBinding.ensureInitialized(); // as i put to the main async
 // notifyHelper().initializeNotification();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider(

        create: (BuildContext context)=>appCubit()..createDB(),
      ), ],
        child: BlocConsumer<appCubit,appStates>(
          listener: (context,state){},
          builder: (context,state)

            {

              return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            home:  Board(),
          );}
        ),


    );
  }
}


