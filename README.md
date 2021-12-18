# Overview
An advanced base template for flutter that includes MVVM and State Management aproaches. This project using mobx libraries 
for state management.
# dependencies
If you wonder what they does these depencies. Chekout the second header 

<pre>
dependencies:
 build_runner: ^2.1.7
  flutter:
    sdk: flutter
  flutter_mobx: ^2.0.2
  mobx: ^2.0.5
  mobx_codegen: ^2.0.4
</pre>
## What Is These Depencies (second header)

* [mobx:](https://pub.dev/packages/mobx)
  * MobX is a library for reactively managing the state of your applications. Use the power of observables, actions, and reactions to supercharge your Dart and Flutter apps.
* [flutter_mobx:](https://pub.dev/packages/flutter_mobx) 
  * Provides the Observer widget that listens to observables and automatically rebuilds on changes. 
  * ```dart
    Observer(builder: (_) => Text(
                        '${_counter.value}',
                     )),//Notice the use of the Observer widget that listens to _counter.value, an observable, and rebuilds on changes.

    ```
* [mobx_codegen:](https://pub.dev/packages/mobx_codegen)
  * Adds support for annotating your MobX code with @observable, @computed, @action, making it super simple to use MobX.
* [build_runner:](https://pub.dev/packages/build_runner)
  * The **build_runner** package provides a concrete way of generating files using Dart code, outside of tools like pub. Unlike **pub serve/build**, files are always generated directly on disk, and rebuilds are incremental - inspired by tools such as Bazel.



# Usefull Plugins For This Project
* [flutter_mobx:](https://marketplace.visualstudio.com/items?itemName=Flutterando.flutter-mobx)
  * Mobx Snnipets and tools to Flutter. Also if you change obervers in store classes this plugin detect that changes and auto generate new mobx codes.
# lib folder
Includes our .dart files's folder tree 
## core/base/state/base_state.dart
This class extends a State and it has two getter method that percentile of height and percentile of width.
```dart
 abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get themeData => Theme.of(context);

  double dynamicHeight(double value) =>
      MediaQuery.of(context).size.height * value;
  double dynamicWidth(double value) =>
      MediaQuery.of(context).size.width * value;
  }   
```
### usage of BaseState class
first extends a state from BaseState
```dart
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}
class _HomeViewState extends BaseState<HomeView> { //extends baseState
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

```
then you can use dynamicHeight, dynamicWidth and ThemeData properties
```dart
    Widget get padding => Padding(
       padding: EdgeInsets.symmetric(vertical: dynamicHeight(0.3),horizontal: dynamicWidth(0.1)),
      );

```
this pattern used to lib/view/home/home_view.dart you can review.
## core/base/view/base_view.dart
BaseView extends StatefulWidget
* T is generic Class that extends Store. Also T is our viewModel class.
* onModelReady Function is Called after initState
* onDispose Called After onDispose
* onPageBuilder our main builder 



```dart
class BaseView<T extends Store> extends StatefulWidget {
  final T viewModel;
  final Function(T model)? onModelReady;
  final VoidCallback? onDispose;
  final Widget Function(BuildContext context, T value) onPageBuilder;

  const BaseView(
      {Key? key,
      required this.viewModel,
      this.onModelReady,
      this.onDispose,
      required this.onPageBuilder})
      : super(key: key);

  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  void initState() {
     super.initState();
    if (widget.onModelReady != null) {
      widget.onModelReady!(widget.viewModel);
    }
  }
  @override
  void dispose() {
    super.dispose();
        if (widget.onDispose != null) {
      widget.onDispose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.onPageBuilder(context,widget.viewModel);
  }
}

```

### usage of BaseView class and creating model class
Firstly create a model class that extends Store. flutter_mobx plugin can help you with their code snippets. Then generate .g.dart file with mobx_codegen for this you can use commandline but I prefer build_runner dependency with flutter_mobx plugin 
```dart
import 'package:mobx/mobx.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
   @observable
 int number =0;

 @action
 void increment(){
   number++;
 }
}
```
Secondly you can use BaseView, BaseState and model class as shown belown<Br>
Notice that you must wrap observable object whit Observer

```dart
import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/base/view/base_view.dart';
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
        },
        onPageBuilder: (context, value) => scaffold);
  }

  Widget get scaffold => Scaffold(
        appBar: appbar,
        floatingActionButton: floatActionButton,
        body: numberShow,
      );

  PreferredSizeWidget get appbar => AppBar(
        title: const Text("advanced MVVM flutter"),
      );

  Widget get floatActionButton => FloatingActionButton(
        onPressed: () {
          viewModel!.number++;
        },
      );

  Widget get numberShow =>  Padding(
            padding: EdgeInsets.symmetric(
                vertical: dynamicHeight(0.3), horizontal: dynamicWidth(0.1)),
            child: Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                color: Colors.blueGrey,
                child: Observer( 
                  builder: (context) {
                    return Text(
                      viewModel!.number.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 70),
                    );
                  }
                )),
          );
        
}

```

