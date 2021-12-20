import 'package:easy_localization/easy_localization.dart';
import 'package:first_three/core/constants/app/app_constants.dart';
import 'package:first_three/core/init/lang/language_manager.dart';
import 'package:first_three/core/init/notifier/provider_list.dart';
import 'package:first_three/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/init/notifier/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(MultiProvider(
    providers: [...ApplicationProvider.instance.dependItems],
    child: EasyLocalization(
        child:  const MyApp(),
        supportedLocales: LanguageManager.instance.supportedLocales,
        path: ApplicationConstants.LANG_ASSET_PATH),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'Flutter Demo',
      theme: context.watch<ThemeNotifier>().currentTheme,
      home: const HomeView(),
    );
  }
}
