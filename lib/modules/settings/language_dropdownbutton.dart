import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/my_provider.dart';
import '../../shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Language_DropDownButton extends StatelessWidget {
  const Language_DropDownButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProvider>(context);
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(left: 15,right: 15),
      decoration: BoxDecoration(
        color:(pro.mode==ThemeMode.light)?Colors.white:
      primaryDark,
        border: Border.all(color: primaryColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          icon: Icon(Icons.keyboard_arrow_down),
          isDense: true,
          iconEnabledColor: primaryColor,
          alignment: Alignment.center,
          value:pro.dropdownValue1,
          items:<String> [
            'English',
            'Arabic'
          ]  .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value,
                child:
                Text((value=='English'?AppLocalizations.of(context)!.buttonEnglish:
                AppLocalizations.of(context)!.buttonArabic), style: TextStyle(
                  color:(pro.languageCode=='en')?primaryColor:
                  primaryColor,fontSize: 15,
                )));
          }).toList(),
          onChanged: (String? newValue) {
            newValue=='English'?
            pro.changeLanguage('en')
                :pro.changeLanguage('ar');
            pro.setSelectedItemLanguage(newValue!);
            pro.dropdownValue1 = newValue;},),
      ),
    );
  }
}