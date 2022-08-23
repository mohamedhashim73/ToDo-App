import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/layouts/home_screen/home_screen.dart';
import 'package:note/layouts/splash_screen/splash_screen.dart';
import 'package:note/shared/bloc_observer.dart';
import 'package:note/shared/cubit/cubit.dart';
import 'package:note/shared/styles/colors.dart';
void main(){
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (BuildContext context)=>AppCubit()..CreateDatabase()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash_Screen(),
        theme: ThemeData(
            appBarTheme:  AppBarTheme(
                color: mainColor,
                elevation: 0,
                surfaceTintColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25))
                ),
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: mainColor,
                elevation: 0
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: mainColor,
            unselectedItemColor: Colors.black54,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.grey[150]
          ),
        ),
      ),
    );
  }
}
