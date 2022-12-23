import 'package:flutter/material.dart';
import '../modules/settings/settings.dart';
import '../modules/tasks_list/tasks_list.dart';




class MyProvider extends ChangeNotifier {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  ThemeMode mode = ThemeMode.light;
  String languageCode = 'en';
  List<String> items1 = ['English,Arabic'];
  String dropdownValue1 = 'English';
  List<String>items2 = ['Light,Dark'];
  String dropdownValue2 = 'Light';
  int currentIndex = 0;
  List<Widget>tabs = [TasksListTab(), SettingsTab()];



  String get selected1 => dropdownValue1;

  void setSelectedItemLanguage(String s) {
    dropdownValue1 = s;
    notifyListeners();
  }


  String get selected2 => dropdownValue2;
  void setSelectedItemMode(String s) {
    dropdownValue2 = s;
    notifyListeners();
  }


  void ShowPicker(context) async {
    DateTime? chosenDate = await showDatePicker(context: context,
      initialDate:selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365),),);
    if (chosenDate == null) return;
    selectedDate = chosenDate;
    notifyListeners();
  }


  void changeThemeMode(ThemeMode thememode) {
    mode = thememode;
    notifyListeners();
  }


  void changeLanguage(String lang) {
    languageCode = lang;
    notifyListeners();

  }


 void changeDate(date) {
    selectedDate = date;
    notifyListeners();
  }
}