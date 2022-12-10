import 'package:flutter/material.dart';
import 'package:todo_app/modules/settings/settings.dart';
import 'package:todo_app/modules/tasks_list/tasks_list.dart';
import 'package:todo_app/shared/styles/colors.dart';

class HomeLayout extends StatefulWidget {
static const String routeName='home';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Route Tasks'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape:StadiumBorder(
          side: BorderSide(
            color: Colors.white,
            width: 3,
          )
        ) ,
        onPressed: (){},
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex:currentIndex ,
          onTap:(index){
            currentIndex=index;
            setState(() {
            });
          },
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.list,size: 30,),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings,size: 30,),label: ''),
          ],
        ),
      ),
      body: tabs[currentIndex],
    );
  }
  List<Widget>tabs=[TasksListTab(),SettingsTab()];
}
