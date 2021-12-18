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
