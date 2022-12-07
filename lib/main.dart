import 'package:flutter/material.dart';
import 'package:todo_app/shared/styles/my_theme.dart';

import 'layout/home_layout.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  initialRoute:HomeLayout.routeName,
      routes:{
    HomeLayout.routeName:(context)=>HomeLayout()
      },
      debugShowCheckedModeBanner: false,
      theme:MyThemeData.lightTheme ,
      darkTheme: MyThemeData.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}

