import 'package:easy_localization/easy_localization.dart';
import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/base/view/base_view.dart';
import 'package:first_three/core/components/text/locale_text.dart';
import 'package:first_three/core/constants/app/enums/app_theme_enum.dart';
import 'package:first_three/core/init/lang/language_manager.dart';
import 'package:first_three/core/init/lang/locale_keys.g.dart';
import 'package:first_three/view/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> {
  HomeViewModel? viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: HomeViewModel(),
        onModelReady: (model) {
          viewModel = model as HomeViewModel;
          viewModel!.setContext(this.context);
        },
        onPageBuilder: (context, value) => scaffold);
  }

  Widget get scaffold => Scaffold(
        appBar: appbar,
        floatingActionButton: floatActionButton,
        body: body,
      );

  PreferredSizeWidget get appbar => AppBar(
        // ignore: prefer_const_constructors
        title: LocalText(value: LocaleKeys.welcome),
      );

  Widget get floatActionButton => FloatingActionButton(
        onPressed: () {
          viewModel!.number++;
        },
        child: const Icon(Icons.add),
      );

  Widget get body {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [numberShow, themesButtonsWidget, languageButtonsWidget]);
  }

  Widget get numberShow => Container(
        alignment: Alignment.center,
        height: dynamicHeight(0.2),
        child: Observer(builder: (context) {
          return Text(
            viewModel!.number.toString(),
            style: const TextStyle(fontSize: 50),
          );
        }),
      );

  Widget get themesButtonsWidget => Container(
      height: dynamicHeight(0.2),
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              viewModel!.changeTheme(AppThemes.LIGHT);
            },
            child: const LocalText(value: LocaleKeys.light_Theme),
          ),
          ElevatedButton(
            onPressed: () {
              viewModel!.changeTheme(AppThemes.DARK);
            },
            child: const LocalText(value: LocaleKeys.dark_Theme),
          ),
        ],
      ));

  Widget get languageButtonsWidget => Container(
      height: dynamicHeight(0.2),
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              context.setLocale(LanguageManager.instance.enLocale);
            },
            // ignore: prefer_const_constructors
            child:  LocalText(value: LocaleKeys.en),
          ),
          ElevatedButton(
            onPressed: () {
              context.setLocale(LanguageManager.instance.germen);
            },
            // ignore: prefer_const_constructors
            child:  LocalText(value: LocaleKeys.de),
          ),
         
        ],
      ));
}
