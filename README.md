# Overview
This is advanced base template included localization and Theme management. This project is upgraded version of  [my previous project](https://github.com/onurcankurum/
Advanced-Fluttter-Base-Template-MVVM-State-Management) that include MVVM and State Management 
![Alt Text](assets/dark_en.jpeg)
![Alt Text](assets/light_en.jpeg)

# dependencies
If you wonder what they does these depencies. Chekout the second header 

<pre>
dependencies:
  build_runner: ^2.1.7
  cupertino_icons: ^1.0.2
  <strong>easy_localization: ^3.0.0</strong>
  flutter:
    sdk: flutter
  flutter_mobx: ^2.0.2
  mobx: ^2.0.5
  mobx_codegen: ^2.0.4
  <strong>provider: ^6.0.1</strong>

</pre>
## What Is These Depencies (second header)

* [easy_localization:](https://pub.dev/packages/easy_localization)
  * This package allows you to translate many languages using Easy Localization Loader, load translations like JSON, CSV, Yaml, Xml. Also can React and persist to locale changes
* [provider:](https://pub.dev/packages/provider)
  * A wrapper around InheritedWidget to make them easier to use and more reusable. 



## 1. Lanuage Management
let's look out core component relating to language managing
### core/init/lang/language_manager.dart
A singleton class for knowing what languages available and selecting a available  language
```dart
class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager get instance {
    if (_instance == null) {
      _instance = LanguageManager._init();
      return _instance!;
    }
    return _instance!;
  }

   final enLocale = const Locale("en","US");
   final germen = const Locale("de","DE");
  List<Locale> get supportedLocales =>[enLocale,germen];

  LanguageManager._init();
  
}
```
### assets/lang*
We have two json files and their keys are exactly same but values different according their languages. Don not forget to these files should named according their locale code. [More information](https://pub.dev/packages/easy_localization)

### EasyLocation widget
Run ensureInitialized method and wrap with EasyLocalization with root widget.  
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(MultiProvider(
    providers: [...ApplicationProvider.instance.dependItems],
    child: EasyLocalization(
        child:  const MyApp(),
        supportedLocales: LanguageManager.instance.supportedLocales,
        path: ApplicationConstants.LANG_ASSET_PATH),//this constant determine that file path that including language translations file 
  ));
}

```
### generating codes
[flutter pub run easy_localization:generate -O lib/core/init/lang -f keys -o locale_keys.g.dart -S assets/lang/]  run this command on terminal. Now we are ready to use localization

### Using Localization
```dart
 Text(LocaleKeys.de).tr()
const LocalText(value: LocaleKeys.de),//this widget is not in localization package only has this project
context.setLocale(LanguageManager.instance.germen);//this line changes the application language



```
## 2. Theme Management
For state management used  provider package. 
#### lib/core/init/thme/app_theme_light.dart
This singleton class has our light theme (also we have same class for darktheme in same path)

```dart
import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppThemeLight extends AppTheme {
  static AppThemeLight? _instance;
  static AppThemeLight get instance {
    if (_instance == null) {
      _instance = AppThemeLight._init();
      return _instance!;
    }
    return _instance!;
  }

  @override
  ThemeData get theme => ThemeData(
        textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.black)),
        scaffoldBackgroundColor: const Color(0xFFe5f0f9),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF639edc),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(primary: const Color(0xFF639edc))),
      );

  AppThemeLight._init();
}
```
#### lib/core/init/notifier/provider_list.dart
This file includes our singleton provider manager.
#### lib/core/init/notifier/theme_notifier.dart
This file allow changing themes to notify listener by provider using enums and aforementioned singleton themes.
```dart
class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppThemeLight.instance.theme;
  AppThemes _currenThemeEnum = AppThemes.LIGHT;

  /// Applicaton theme enum.
  /// Deafult value is [AppThemes.LIGHT]
  AppThemes get currenThemeEnum => _currenThemeEnum;

  ThemeData get currentTheme => _currentTheme;

  void changeValue(AppThemes theme) {
    if (theme == AppThemes.LIGHT) {
      _currentTheme = AppThemeLight.instance.theme;
    } else {
      _currentTheme = AppThemeDark.instance.theme;
    }
    notifyListeners();
  }

  /// Change your app theme with [currenThemeEnum] value.
  void changeTheme() {
    if (_currenThemeEnum == AppThemes.LIGHT) {
      _currentTheme = ThemeData.dark();
      _currenThemeEnum = AppThemes.DARK;
    } else {
      _currentTheme = AppThemeDark.instance.theme;
      _currenThemeEnum = AppThemes.LIGHT;
    }
    notifyListeners();
  }
}

```
#### using provider widget
Use Multiprovider for and add providers. now we can change themes

```dart
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

```
#### changing themes
Can change the theme

```dart
  Provider.of<ThemeNotifier>(context!,listen: false).changeValue(AppThemes.DARK);

```