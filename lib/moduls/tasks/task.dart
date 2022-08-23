import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/shared/components/component.dart';
import 'package:note/shared/styles/colors.dart';
import '../../layouts/task_body/tasks_body.dart';
import '../../shared/components/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/styles.dart';
class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var _cubit = AppCubit.get(context); // object from cubit
        return
          _cubit.newTasks.isEmpty ?
           const Center(child: Text("No Tasks have been added yet",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)) :
           Container(
             width: double.infinity,
             margin: const EdgeInsets.symmetric(vertical: 2.5),
             child: ListView.separated(
               physics: BouncingScrollPhysics(),
             itemBuilder: (context,i){
              return Dismissible(
                onDismissed: (direction) {
                  _cubit.DeleteDatebase(id: _cubit.newTasks[i]['id']);
                  snackBar = const SnackBar(content: Text("Deleted Successfully"),duration: Duration(microseconds: 2),);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                key: Key(_cubit.newTasks[i]['id'].toString()),
                child: GestureDetector(
                  onTap: ()   // click to show note body
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskBodyScreen(text: '${_cubit.newTasks[i]['title']}',)));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 12,top: 15),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Container(
                          height: 65,
                          width: 65,
                          child: CircleAvatar(
                            backgroundColor:mainColor,
                            maxRadius: 30,
                            child:Text("${_cubit.newTasks[i]['time']}",style: TextStyle(fontSize: 10),),
                          ),
                        ),
                        DefaultHorizontalSpace(width: 8),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 90,
                            margin: const EdgeInsets.fromLTRB(10, 7, 0, 7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children:
                              [
                                Expanded(
                                    child: Container(
                                      margin:const EdgeInsets.only(right: 18),
                                      child: Text("${_cubit.newTasks[i]['title']}",
                                          style: titleStyle,maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children:
                                  [
                                    Text("Ex time : ",style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.6)),),
                                    Text("${_cubit.newTasks[i]['date']}",style: dateStyle,),
                                    DefaultHorizontalSpace(width: 31),
                                    Expanded(
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.cloud_done,color: secondColor,size: 22,),
                                              onPressed: (){
                                                _cubit.UpdateDatebase(status: 'done', id: _cubit.newTasks[i]['id']);
                                                snackBar = const SnackBar(content: Text("Moved to Done Tasks"),duration: Duration(microseconds: 2),);
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.archive,color: secondColor,size: 22,),
                                              onPressed: (){
                                                _cubit.UpdateDatebase(status: 'archive', id: _cubit.newTasks[i]['id']);
                                                snackBar = const SnackBar(content: Text("Moved to Archived Tasks"),duration: Duration(microseconds: 2),);
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                              },
                                            ),
                                      ],
                                    ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
          },
           separatorBuilder: (context,i)=>
               Container
                 (
                 margin:const EdgeInsets.symmetric(horizontal: 20),
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Color.fromARGB(255, 100, 138, 130).withAlpha(50),),
                 width: double.infinity,height: 1,
                 ),
           itemCount: _cubit.newTasks.length,
            ),
           )
        ;
      },
    );
  }
}
