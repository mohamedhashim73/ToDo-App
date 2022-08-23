import 'package:flutter/material.dart';
import 'package:note/shared/styles/colors.dart';
// TextFormField
Widget DefaultTextFormField ({
  required TextEditingController controller,
  required TextInputType type,
  Text? label,
  required Function validatorFunction,
}) {
  return TextFormField(
    keyboardType: type,
    controller: controller,
    validator: validatorFunction(),
    decoration: InputDecoration(
      label: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    ),
  );
}

// Vertical Space
Widget DefaultVerticalSpace({required double height}) => SizedBox(height: height);

Widget DefaultHorizontalSpace({required double width}) => SizedBox(width: width);

Widget defaultDrawer ()
{
  return Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          color: mainColor,
          padding: const EdgeInsets.fromLTRB(20,30,10,10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(maxRadius:35,backgroundColor: Colors.white,backgroundImage: AssetImage("images/me.jpg")),
              DefaultVerticalSpace(height: 13),
              const Text("Mohamed Hashim",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
              DefaultVerticalSpace(height: 7),
              const Text("muhamedhashim73@gmail.com",style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
        Container(
          // color: Colors.grey.withOpacity(0.5),
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20,top: 20),
          child: Column(
            children: [
              Row(
                children:
                [
                  Icon(Icons.home,color: Colors.black.withOpacity(0.5),),
                  DefaultHorizontalSpace(width: 15),
                  Text("Home"),
                ],
              ),
              DefaultVerticalSpace(height: 20),
              Row(
                children:
                [
                  Icon(Icons.note_add,color: Colors.black.withOpacity(0.5),),
                  DefaultHorizontalSpace(width: 15),
                  Text("Type your task"),
                ],
              ),
              DefaultVerticalSpace(height: 20),
              Row(
                children:
                [
                  Icon(Icons.archive,color: Colors.black.withOpacity(0.5),),
                  DefaultHorizontalSpace(width: 15),
                  Text("Archive"),
                ],
              ),
              DefaultVerticalSpace(height: 20),
              Row(
                children:
                [
                  Icon(Icons.restore_from_trash,color: Colors.black.withOpacity(0.5),),
                  DefaultHorizontalSpace(width: 15),
                  Text("Trash"),
                ],
              ),
              DefaultVerticalSpace(height: 20),
              Row(
                children:
                [
                  Icon(Icons.settings,color: Colors.black.withOpacity(0.5),),
                  DefaultHorizontalSpace(width: 15),
                  Text("Settings"),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
