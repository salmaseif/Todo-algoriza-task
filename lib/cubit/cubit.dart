import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_algoriza/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class appCubit extends Cubit<appStates>
{
  int? index;
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var starttimeController = TextEditingController();
  var endtimeController = TextEditingController();
  var repeatController = TextEditingController();
  var  remindController = TextEditingController();
  DateTime selectedDate=DateTime.now();
  int selected_remind = 5;
  int selectedcolor=0;
  String selectedRepeat = 'None';
 List<bool>? isChecked;
 bool ischeck=false;
 bool isfavicon=false;
  bool flag = false;
  bool flagp = false;
  List<Map>? datetasks;
  List<Map> Alltasks=[];
  List<Map> completedtasks=[];
  List<Map> uncompletedtasks=[];
  List<Map> favouritetasks=[];
  late Database database;
  bool flagd=false;
  static appCubit get(context)=>BlocProvider.of(context);
  appCubit() : super(appInitialState());
  void createcheckbox(){

      int y = 15;

       isChecked = List.generate(y, (position) => false);


  }
  void checkchange(bool vall,int index){
  // isChecked![index]=vall;
    ischeck=vall;
    emit(appchangecheck());
 }
 void clear()
 {

   titleController = TextEditingController();
    dateController = TextEditingController();
    starttimeController = TextEditingController();
 endtimeController = TextEditingController();
    repeatController = TextEditingController();
     remindController = TextEditingController();
     flag=false;
     flagp=false;
 }
  void remindchange(int remind){
    // isChecked![index]=vall;
    flag=true;
   selected_remind=remind;
    emit(remindchangedState());
  }
  void repeatchange(String repeat){
    // isChecked![index]=vall;
    flagp=true;
    selectedRepeat=repeat;
    emit(repeatchangedState());
  }
  List<Map>? datechanged(DateTime date)
  {
flagd=true;
selectedDate=date;
String datee=DateFormat('yyyy-MM-dd').format(selectedDate);
// for(Map element in Alltasks)
// {
//
//   if (element['date']==datee)
//
//     {
//       datetasks?.add(element);
//
//     }
//
//
//
// }

emit(datechangedState());


  }
  void getitemsbasedondb()
  {


  }
  void toggle_icon(){
    if(isfavicon)
      {
        isfavicon=false;
      }
   else
     {
       isfavicon=true;
     }
emit(favtoggleState());
  }
  void createDB()async{
   openDatabase("todo.db", version: 1,
       onCreate: (database, version) {
        print("database created");
        database
            .execute(
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, starttime TEXT, "
                "endtime TEXT, status TEXT , repeat TEXT, remind INTEGER ,  iscomp INTEGER,  isfav INTEGER , color INTEGER)")
            .then((value) {
         print("table created");
        }).catchError((error) {
         print("error when create db");
        });
       }, onOpen: (database) {
        getFromDb(database);
        print("database opened");
       }).
   then((value) {
    database=value;
    emit(AppCreateDbState());
   }) ;
  }

  void updateData(int iscomp,int id)async
  {
   database.rawUpdate(
       "UPDATE tasks SET iscomp = ? WHERE id= ?",
       ['$iscomp',id]
   ).then((value) {
    getFromDb(database);
    emit(AppUpdateDbState());

   });


  }
  void updateData2(int isfav,int id)async
  {
    database.rawUpdate(
        "UPDATE tasks SET isfav = ? WHERE id= ?",
        ['$isfav',id]
    ).then((value) {
      getFromDb(database);
      emit(AppUpdateDbState());

    });


  }
  void updateData3(int color,int id)async
  {
    database.rawUpdate(
        "UPDATE tasks SET isfav = ? WHERE id= ?",
        ['$color',id]
    ).then((value) {
      getFromDb(database);
      emit(AppUpdateDbState());

    });


  }
  void changedate(DateTime date)
  {
    selectedDate=date;
    emit(datechangedState());
  }
  void changestime(DateTime date)
  {
    selectedDate=date;
    emit(datechangedState());
  }
  void changeetime(DateTime date)
  {
    selectedDate=date;
    emit(datechangedState());
  }
  void colorChanged(int index)
  {
    selectedcolor=index;
    emit(colorchangedState() );
  }
  void deleteData(int id)async
  {
   database.rawDelete(
       "DELETE FROM tasks WHERE id = ? ",[id]

   ).then((value) {
    getFromDb(database);
    emit(AppDeleteDbState());

   });


  }
  insertToDB(String title,String stime,String etime,String date,String repeat, int remind,int selectedcolor)async {

   await database.transaction((txn)async {
    txn.rawInsert(
        'INSERT INTO tasks(title, date, starttime, endtime, status, repeat, remind , iscomp , isfav, color) VALUES("$title","$date","$stime","$etime","new","$repeat","$remind","0","0","$selectedcolor")').then((value) {


     print("uer data inserted $value");
     emit(AppInsertDbState());
     getFromDb(database);
    }).catchError((error){
     print("error whrn insert$error");
    });
    //print('inserted2: ${y}');


   });


  }

  void getFromDb(database)
  {
 Alltasks=[];
completedtasks=[];
 uncompletedtasks=[];
favouritetasks=[];
   emit(AppgetDbLoadingState());
   database.rawQuery('SELECT * FROM tasks').then((value) {


    value.forEach((element) {
     Alltasks.add(element);
     print(element['status']);
     if(element['iscomp']==1)
      completedtasks.add(element);


     if(element['iscomp']==0)
      uncompletedtasks.add(element);
    if(element['isfav']==1)
      favouritetasks.add(element);

    });
    print("$Alltasks this all tasks");
    print("$completedtasks this completed tasks");
    print("$favouritetasks this fav tasks");
    emit(AppgetDbState());
   });


  }

}