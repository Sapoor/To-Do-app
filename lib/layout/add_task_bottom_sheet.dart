import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/tasks.dart';
import 'package:todo_app/provider/my_provider.dart';
import 'package:todo_app/shared/styles/colors.dart';
import '../shared/components/components.dart';
import '../shared/network/local/firebase_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatelessWidget {

  DateTime selectedDate = DateTime.now();

  @override

  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.headoftask,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: (pro.mode == ThemeMode.light)
                          ? colorBlack
                          : Colors.white,
                    ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
                key: pro.formkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (text) {
                        if (text == '') {
                          return 'Please Enter Title';
                        }
                        return null;
                      },
                      controller: pro.titleController,
                      decoration: InputDecoration(
                          label: Text(
                              AppLocalizations.of(context)!.titleoftask,
                            style: TextStyle(
                              color: (pro.mode == ThemeMode.light)
                                  ? colorBlack
                                  : Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: primaryColor,
                          )),
                          border: OutlineInputBorder(borderSide: BorderSide())),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (text) {
                        if (text == '') {
                          return 'Please Enter Description';
                        }
                        return null;
                      },
                      controller: pro.descriptionController,
                      decoration: InputDecoration(
                          label: Text(
                            AppLocalizations.of(context)!.descriptionoftask,
                            style: TextStyle(
                              color: (pro.mode == ThemeMode.light)
                                  ? colorBlack
                                  : Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: primaryColor,
                          )),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: primaryColor,
                          ))),
                    )
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Text(
                AppLocalizations.of(context)!.dateoftask,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: (pro.mode == ThemeMode.light)
                        ? colorBlack
                        : Colors.white,
                  ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                pro.ShowPicker(context);
              },
              child: Text(
                  '${pro.selectedDate.year}/${pro.selectedDate.month}/${pro.selectedDate.day}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: (pro.mode == ThemeMode.light)
                          ? colorBlack
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (pro.formkey.currentState!.validate()) {
                    TaskData task = TaskData(
                        title: pro.titleController.text,
                        description: pro.descriptionController.text,
                        date: DateUtils.dateOnly(selectedDate).microsecondsSinceEpoch);
                    showLoading(context,'Loading...');
                    addTaskToFirebaseFirestore(task).then((value){
                      hideLoading(context);
                    showMessage(context,  AppLocalizations.of(context)!.titlemessage, 'OK', () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },negBtn: 'Cancel',negAction:(){});
                    }).catchError((error){
                      print (error);
                    });
                  }
                },
                child: Text(
                    AppLocalizations.of(context)!.buttontask,
                  style: TextStyle(
                    color: (pro.mode == ThemeMode.light)
                        ? colorBlack
                        : Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
