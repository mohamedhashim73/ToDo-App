import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import '../../moduls/archived_tasks/archieved.dart';
import '../../moduls/done_tasks/done.dart';
import '../../moduls/tasks/task.dart';
class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super (AppInitialState());
  static AppCubit get(BuildContext context) => BlocProvider.of(context);
  Database? db;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedtasks = [];
  int currentIndex = 0;
  bool bottomSheetShown = false ;
  List<Widget> homeScreens =         // screens in Home Page
  [
    TasksScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];
  List<String> homeScreensTitles =   // appBar titles for home screen
  [
    "Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];

  void changeBottomNavigationIndex({required int index})
  {
    currentIndex = index;
    emit(ChangeBottomNavigationIndexState());
  }

  void changeBottomSheetShownIndex({required bool shown})
  {
    bottomSheetShown = shown;
    emit(ChangeBottomSheetShownState());
  }
  // Database operations
  // 1. CreateDatabase
void CreateDatabase() async
{
    openDatabase(
      'notes.db',
      version: 1,
      onCreate: (database,version)
      {
        database.execute(
            'CREATE TABLE notes(id INTEGER PRIMARY KEY NOT NULL,title TEXT NOT NULL,date TEXT NOT NULL,time TEXT NOT NULL,status TEXT NOT NULL)')
            .then((value) => print("Table created successfully"));
      },
      onOpen: (database){
        print("Database opened successfull");
      }
    ).then((value) {
      db = value;
      emit(CreateDatabaseState());
      GetDataFromDatabase(db!);
    });
}
  // 2. Insert Data to Database
void InsertDataToDatabase({
  required String title,
  required String date,
  required String time,
})
{
  db?.transaction((txn) async {
    txn.rawInsert('INSERT INTO notes(title,date,time,status) VALUES ("${title}","${date}","${time}","new")');
  }).then((val)
        {
          emit(InsertToDatabaseState());
          print("Data was inserted to Database are => ${val}");
          GetDataFromDatabase(db!);
        }).catchError((e)=>print(e));
}

 // 3. Get Database
void GetDataFromDatabase(Database database)
{
    newTasks = [];
    doneTasks = [];
    archivedtasks = [];
    db?.rawQuery('SELECT * FROM notes').then((val)
    {
      val.forEach((element) {
        if(element['status'] == 'new')
          {
            newTasks.add(element);
          }
        else if(element['status'] == 'done')
        {
          doneTasks.add(element);
        }
        else
        {
          archivedtasks.add(element);
        }
      });
      emit(GetDatabaseState());
      print("Data was get successfully");
    }).catchError((e)=>print("Error during getting Data for Database"));
}

 // 4. Update Database
void UpdateDatebase({required String status,required int id}) {
    db?.rawUpdate(
        'UPDATE notes SET status = ? WHERE id = ?',
        ['${status}',id]
    ).then((value)
    {
      emit(UpdateDatabaseState());
      GetDataFromDatabase(db!);
    }).catchError((e)=>print(e.toString()));
}

// Delete database
  void DeleteDatebase({required int id}) {
    db?.rawUpdate(
        'DELETE FROM notes WHERE id = ?',
        [id]
    ).then((value)
    {
      emit(DeleteDatabaseState());
      GetDataFromDatabase(db!);
    }).catchError((e)=>print(e.toString()));
  }

  // for background color
  List<Color> colors =
  [
    Colors.white,
    Colors.green,
    Colors.grey,
    Colors.deepOrange,
  ];
  var selectedcolor = Colors.white;
  void selectBackgroundColor(int index)
  {
    selectedcolor = colors[index];
    emit(changebackgroundColor());
  }
}