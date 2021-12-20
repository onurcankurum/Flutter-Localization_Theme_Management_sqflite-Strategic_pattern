import 'package:first_three/core/constants/app/enums/app_theme_enum.dart';
import 'package:first_three/core/init/notifier/theme_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
BuildContext? context;

void setContext(BuildContext context){
  this.context=context;
}

void changeTheme(AppThemes theme){
  Provider.of<ThemeNotifier>(context!,listen: false).changeValue(theme);
}

   @observable
 int number =0;

 @action
 void increment(){
   number++;
 }
}