import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import '../../shared/components/component.dart';
import '../../shared/components/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
// contain BottomNavigationBar
class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldState =  GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formState =  GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var _cubit = AppCubit.get(context); // object from cubit
        return Form(
          key: _formState,
          child: Scaffold(
            key: _scaffoldState,
            drawer: defaultDrawer(),
            appBar: AppBar(title: Text(_cubit.homeScreensTitles[_cubit.currentIndex]),),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: AppCubit.get(context).currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index){
                _cubit.changeBottomNavigationIndex(index: index);
              },
              items:
              const [
                BottomNavigationBarItem(label: "Tasks",icon: Icon(Icons.event_note)),
                BottomNavigationBarItem(label: "Done",icon: Icon(Icons.cloud_done)),
                BottomNavigationBarItem(label: "Archived",icon: Icon(Icons.archive)),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: ()
              {
                // initial for shown == false
                if(_cubit.bottomSheetShown == true)
                {
                  if(_formState.currentState!.validate())  // if validator return null
                  {
                    _cubit.InsertDataToDatabase(
                      title: titleController.text.toString(),
                      date: dateController.text.toString(),
                      time: TimeOfDay.now().format(context).toString(),
                    );
                    if(Navigator.canPop(context))
                      {
                        Navigator.pop(context);
                        titleController.text = dateController.text = "";
                        // Show SnackBar message
                        snackBar = const SnackBar(content: Text("Task added successfully"),duration: Duration(microseconds: 1),);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    _cubit.changeBottomSheetShownIndex(shown: false);
                  }
                }
                else
                {
                  // ShowBottomSheet
                  _scaffoldState.currentState!.showBottomSheet((context){
                    return Container(
                      color: Colors.white10,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: titleController,
                            validator: (val){
                              if(titleController.text.isEmpty)
                              {
                                return "title must not be empty";
                              }
                              else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              label: const Text("Task title"),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                          DefaultVerticalSpace(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.datetime,
                            controller: dateController,
                            onTap: (){
                              showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022, 8),
                                  lastDate:DateTime(2024, 8),
                              ).then((value){
                                print("${Jiffy(value.toString()).MMM}");
                                dateController.text = Jiffy(value).yMMMMd.toString();
                              });
                            },
                            validator: (val){
                              if(dateController.text.isEmpty)
                              {
                                return "Date must not be empty";
                              }
                              else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              label: const Text("Expected Date "),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                          /*
                          DefaultVerticalSpace(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: timeController,
                            onTap: ()
                            {
                              showTimePicker(context: context, initialTime: TimeOfDay.now()).then((val) {
                                String? s = val?.format(context);
                                timeController.text = s!;
                              });
                            },
                            validator: (val){
                              if(timeController.text.isEmpty)
                              {
                                return "time must not be empty";
                              }
                              else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              label: Text("Enter task time"),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                           */
                        ],
                      ),
                    );
                  },
                  ).closed.then((value){
                    // back to initial shown == false
                    _cubit.changeBottomSheetShownIndex(shown: false);
                    if(Navigator.canPop(context))
                    {
                      Navigator.pop(context);
                    }
                  });
                  _cubit.changeBottomSheetShownIndex(shown: true);
                }
              },
            ),
            body: _cubit.homeScreens[_cubit.currentIndex],
          ),
        );
      },
    );
  }
}
