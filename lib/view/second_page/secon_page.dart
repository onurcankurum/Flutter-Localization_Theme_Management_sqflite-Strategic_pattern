import 'dart:html';

import 'package:first_three/core/components/text/locale_text.dart';
import 'package:first_three/core/constants/navigation/navigation_constants.dart';
import 'package:first_three/core/init/lang/locale_keys.g.dart';
import 'package:first_three/core/init/navigation/navigation_service.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return scaffold;
  }

  Widget get scaffold => Scaffold(
      appBar: appBar,
      body: Container(alignment: Alignment.center, child: body));
  PreferredSizeWidget get appBar => AppBar(
        title: LocalText(value: LocaleKeys.second_page),
      );
  Widget get body => Center(child: buttons);

  Widget get buttons => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            child: Text("back to home page"),
            onPressed: () {
              NavigationService.instance.navigateToPageClear(
                path: NavigationConstants.HOME_VIEW,
              );
            },
          ),
        ],
      );
}
