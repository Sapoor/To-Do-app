import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/tasks.dart';
import 'package:todo_app/modules/tasks_list/task_item.dart';
import 'package:todo_app/shared/styles/colors.dart';

import '../../provider/my_provider.dart';
import '../../shared/network/local/firebase_utils.dart';

class TasksListTab extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProvider>(context);
    return Column(
      children: [
        CalendarTimeline(
          initialDate:pro.selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => {
            pro.selectedDate=date,
            pro.changeDate(pro.selectedDate),
            },
          leftMargin: 20,
          monthColor: (pro.mode==ThemeMode.light)?colorBlack:
    Colors.white,
          dayColor: (pro.mode==ThemeMode.light)?primaryColor:
    Colors.white,
          activeDayColor: (pro.mode==ThemeMode.light)?primaryColor:
          Colors.white,
          activeBackgroundDayColor:(pro.mode==ThemeMode.light)?Colors.white:
          primaryColor,
          dotsColor:(pro.mode==ThemeMode.light)?primaryColor:
          Colors.white,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        StreamBuilder<QuerySnapshot<TaskData>>(
            stream: getTasksFromFirestore(pro.selectedDate),
            builder:(context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return Center(child: Text('Something went wrong',
                  style:TextStyle(color:(pro.mode==ThemeMode.light)?primaryColor:
                  Colors.white,),));
              }
              var tasks=snapshot.data?.docs.map((doc) => doc.data()).toList()??[];
              if(tasks.isEmpty){
                return Center(child: Text('No Data',
                  style:TextStyle(color:(pro.mode==ThemeMode.light)?primaryColor:
                  Colors.white,fontWeight: FontWeight.bold,fontSize: 15 ),));
              }
              return Expanded(
                child: ListView.builder(
                  itemCount:tasks.length ,
                    itemBuilder:(context,index){
                      return TaskItem(tasks[index]);
                    }),
              );
            })
      ],
    );
  }
}
