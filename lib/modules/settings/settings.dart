import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/my_provider.dart';
import '../../shared/styles/colors.dart';
import 'language_dropdownbutton.dart';
import 'mode_dropdownbutton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35,vertical: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.titleButton,style:TextStyle(
            color: (pro.mode==ThemeMode.light)? primaryDark:
           Colors.white,fontSize: 15,fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 25,),
          Language_DropDownButton(),
          SizedBox(height: 30,),
          Text(AppLocalizations.of(context)!.titleBtn,style:TextStyle(
            color: (pro.mode==ThemeMode.light)? primaryDark:
            Colors.white,fontSize: 15,fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 25,),
        Mode_DropDownButton(),
        ],
      ),
    );
  }
}