import 'package:first_three/core/base/state/base_state.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}
class _HomeViewState extends BaseState<HomeView> { //eztends baseState
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
    Widget get floatActionButton => Padding(
       padding: EdgeInsets.symmetric(vertical: dynamicHeight(0.3),horizontal: dynamicWidth(0.1)),
      );
}
