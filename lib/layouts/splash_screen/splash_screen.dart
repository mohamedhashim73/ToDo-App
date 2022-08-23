import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note/layouts/home_screen/home_screen.dart';
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 4)).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircleAvatar(maxRadius: 50,child: Image.asset("images/tasks.png"),),
      ),
    );
  }
}
