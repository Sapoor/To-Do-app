import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/shared/components/components.dart';
import '../../models/tasks.dart';
import '../../provider/my_provider.dart';
import '../../shared/network/local/firebase_utils.dart';
import '../../shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class taskEdit extends StatelessWidget {
  TaskData task;

  taskEdit(this.task);

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor:
          (pro.mode == ThemeMode.light) ? greenBackground : primaryDark,
      extendBody: true,
      appBar: AppBar(
        title: Text('Route Tasks'),
      ),
      body: Container(
        height: double.infinity,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (pro.mode == ThemeMode.light) ? Colors.white : primaryDark,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  AppLocalizations.of(context)!.headofedit,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: (pro.mode == ThemeMode.light)
                          ? colorBlack
                          : Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
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
                              AppLocalizations.of(context)!.titleofedit,
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
                            border:
                                OutlineInputBorder(borderSide: BorderSide())),
                      ),
                      SizedBox(
                        height: 25,
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
                              AppLocalizations.of(context)!.descriptionofedit,
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
                height: 25,
              ),
              Container(
                child: Text(
                  AppLocalizations.of(context)!.dateofedit,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: (pro.mode == ThemeMode.light)
                            ? colorBlack
                            : Colors.white,
                      ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: InkWell(
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
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 40,
                width: 220,
                child: ElevatedButton(
                  onPressed: () {
                    updateTaskFromFirebaseFirestore(
                            task.id,
                            pro.titleController.text,
                            pro.descriptionController.text)
                        .then((value) {
                      showMessage(context,  AppLocalizations.of(context)!.titleeditmessage, 'ok',
                          () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      });
                    });
                  },
                  child: Text(
                    AppLocalizations.of(context)!.buttonedit,
                    style: TextStyle(
                      color: (pro.mode == ThemeMode.light)
                          ? colorBlack
                          : Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
