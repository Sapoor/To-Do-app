import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/models/tasks.dart';
import 'package:todo_app/modules/tasks_list/task_edit.dart';
import 'package:todo_app/shared/styles/colors.dart';
import '../../shared/network/local/firebase_utils.dart';

class TaskItem extends StatefulWidget {
  TaskData task;
  TaskItem(this.task);


  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool click =false;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              deleteTaskFromFirestore(widget.task.id);
            },
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context)=>editTodo(context, widget.task),
            backgroundColor: Colors.blue,

            icon: Icons.edit,
            label: 'Edit',
          )
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 4,
              color: (click==false)?primaryColor:colorGreen,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title,
                    style: TextStyle(
                      color: (click==false)?primaryColor:colorGreen,fontSize: 20,fontWeight: FontWeight.bold
                    )),
                  Text(widget.task.description,
                    style:  TextStyle(
                        color: (click==false)?primaryColor:colorGreen,fontSize: 20,fontWeight: FontWeight.bold
                    )),
                ],
              ),
            ),
            InkWell(
              onTap: (){
                click=!click;
                completeTask(widget.task.id);
                setState(() {
                });
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child:
                  (click==false)? Icon(
                    Icons.done,size: 30,color: primaryColor,):
                  Text('Done!', style: TextStyle(color:colorGreen,fontSize: 25,fontWeight: FontWeight.bold),),
                  )),
          ],
        ),
      ),
    );
  }
}

void editTodo(BuildContext context, TaskData taskData) => Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => taskEdit(taskData),
  ),
);

