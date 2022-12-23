import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/my_provider.dart';
import '../../shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Mode_DropDownButton extends StatelessWidget {
  const Mode_DropDownButton({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return  Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          color:(pro.mode==ThemeMode.light)?Colors.white:
          primaryDark,
          border: Border.all(color: primaryColor),
        ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton(
                isDense: true,
                icon: Icon(Icons.keyboard_arrow_down),
                iconEnabledColor: primaryColor,
                alignment: Alignment.center,
                value: pro.dropdownValue2,
                items: <String>[
                  'Light',
                  'Dark']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value=='Light'?AppLocalizations.of(context)!.btnLight:
                    AppLocalizations.of(context)!.btnDark,
                        style: TextStyle(
                            color:  primaryColor,
                            fontSize: 15)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  newValue=='Light'?
                      pro.changeThemeMode(ThemeMode.light)
                      :pro.changeThemeMode(ThemeMode.dark);
                  pro.setSelectedItemMode(newValue!);
                  pro.dropdownValue2 = newValue;
                }),
          ),);
  }
}
