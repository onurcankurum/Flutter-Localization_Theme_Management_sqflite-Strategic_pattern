import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/components/text/locale_text.dart';
import 'package:first_three/core/constants/navigation/navigation_constants.dart';
import 'package:first_three/core/init/lang/locale_keys.g.dart';
import 'package:first_three/core/init/navigation/navigation_service.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends BaseState<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return scaffold;
  }

  Widget get scaffold => Scaffold(appBar: appbar, body: Center(child: body));
  PreferredSizeWidget get appbar => AppBar(title: LocalText(value: LocaleKeys.first_page));
  Widget get body => Center(child: buttons);

  Widget get buttons => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            child:  LocalText(value: LocaleKeys.next_page),
            onPressed: () {
              NavigationService.instance
                  .navigateToPage(path: NavigationConstants.SECOND_PAGE);
            },
          ),
          ElevatedButton(
            child:  LocalText(value: LocaleKeys.previous_page),
            onPressed: () {
              NavigationService.instance
                  .navigateToPageClear(path: NavigationConstants.HOME_VIEW);
            },
          )
        ],
      );
}
