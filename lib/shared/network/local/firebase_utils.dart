import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/tasks.dart';


CollectionReference<TaskData>getTaskCollection(){
 return FirebaseFirestore.instance.collection('tasks')
      .withConverter<TaskData>(
      fromFirestore: (snapshot,sp)=>TaskData.fromJson(snapshot.data()!),
      toFirestore: (task,sp)=>task.toJson());
}


Future<void> addTaskToFirebaseFirestore(TaskData taskData){
var collection = getTaskCollection();
 var  docRef= collection.doc();
 taskData.id=docRef.id;
return docRef.set(taskData);
}

Stream<QuerySnapshot<TaskData>> getTasksFromFirestore(DateTime datetime){
 return getTaskCollection().where('date',isEqualTo:DateUtils.dateOnly(datetime).microsecondsSinceEpoch).snapshots();
}

Future <void> deleteTaskFromFirestore(String id){
return getTaskCollection().doc(id).delete();
}

Future<void> updateTaskFromFirebaseFirestore(String id,String title,String description) {
 return getTaskCollection().doc(id).update({
  "title": title,
  "description": description
 });
}

Future completeTask(String id)async{
 return getTaskCollection().doc(id).update({
  "isDone":true,
 });
}
