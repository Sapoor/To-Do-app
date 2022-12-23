import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/shared/styles/colors.dart';
import '../provider/my_provider.dart';
import 'add_task_bottom_sheet.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: (pro.mode == ThemeMode.light) ? greenBackground : primaryDark,
      extendBody: true,
      appBar: AppBar(
        title: Text('Route Tasks'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
            side: BorderSide(
          color: Colors.white,
          width: 3,
        )),
        onPressed: () {
          showAddTaskBottomSheet(pro);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: (pro.mode == ThemeMode.light) ? Colors.white : primaryDark,
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: pro.currentIndex,
          onTap: (index) {
            pro.currentIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 30,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  size: 30,
                ),
                label: ''),
          ],
        ),
      ),
      body: pro.tabs[pro.currentIndex],
    );
  }

  void showAddTaskBottomSheet(var pro) {
    showModalBottomSheet(
        backgroundColor:
            (pro.mode == ThemeMode.light) ? Colors.white : primaryDark,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddTaskBottomSheet(),
            ));
  }
}
