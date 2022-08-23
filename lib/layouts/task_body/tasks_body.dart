import'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/shared/components/component.dart';
import 'package:note/shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';
class TaskBodyScreen extends StatelessWidget {
  String? text ;
  TaskBodyScreen({required this.text});
  GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state)=>AppCubit(),
      builder: (context,state){
        var _cubit = AppCubit.get(context);
        return Scaffold(
            key: _scaffoldState,
            backgroundColor: _cubit.selectedcolor,
            appBar: AppBar(
              backgroundColor: _cubit.selectedcolor,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              foregroundColor: Colors.black.withOpacity(0.8),
              actions: 
              [
                IconButton(onPressed: (){}, icon: Icon(Icons.archive)),
              ],
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.only(top: 10),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children:
                [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height : 25,child: Text("Title",style: TextStyle(color: Colors.black,fontSize: 20),),),
                          DefaultVerticalSpace(height: 7),
                          Expanded(
                            child: ListView(
                              children:
                              [
                                Wrap(
                                  children: [
                                    Text("${text}",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                                  ],
                                )
                              ],
                            ),)
                        ],
                      )
                  ),
                  Container(
                    height: 40,
                    // color: Colors.green.withOpacity(0.2),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: (){
                              _scaffoldState.currentState!.showBottomSheet((context) {
                                return Container(
                                    height: 50,
                                    padding: const EdgeInsets.all(10),
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Row(
                                      children: [
                                        Text("Select Color",style: const TextStyle(fontWeight: FontWeight.bold)),
                                        DefaultHorizontalSpace(width: 15),
                                        ListView.separated(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context,i){
                                              return GestureDetector(
                                                  onTap: (){
                                                    _cubit.selectBackgroundColor(i);
                                                    Navigator.pop(context);
                                                  },
                                                  child: CircleAvatar(maxRadius: 25,backgroundColor: colors[i],)
                                              );
                                            },
                                            separatorBuilder: (context,i)=>DefaultHorizontalSpace(width: 5),
                                            itemCount: colors.length
                                        ),
                                      ],
                                    )
                                );
                              });
                            },
                            icon: const Icon(Icons.color_lens,size: 25,color: Colors.black,)),
                        IconButton(
                            onPressed: (){
                              _scaffoldState.currentState!.showBottomSheet((context){
                                return Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Do tou want to delete this"),
                                      TextButton(
                                          onPressed: (){}, child: Text("Delete"))
                                    ],
                                  ),
                                );
                              });
                            }, icon: const Icon(Icons.more_vert,size: 25,color: Colors.black,)),
                      ],
                    ),
                  ),
                ],
              ),
            )
        );
      }
    );
  }
}
