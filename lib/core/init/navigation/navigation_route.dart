import 'package:first_three/core/components/init/not_found_widget.dart';
import 'package:first_three/core/constants/navigation/navigation_constants.dart';
import 'package:first_three/view/first_page/first_page_view.dart';
import 'package:first_three/view/home/home_view.dart';
import 'package:first_three/view/second_page/secon_page.dart';
import 'package:flutter/material.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.HOME_VIEW:
        return normalNavigate( const HomeView(), NavigationConstants.HOME_VIEW);
      case NavigationConstants.FIRST_PAGE:
        return normalNavigate(FirstPage(), NavigationConstants.FIRST_PAGE);
      case NavigationConstants.SECOND_PAGE:
        return normalNavigate(SecondPage(), NavigationConstants.SECOND_PAGE);
      default:
        return MaterialPageRoute(
          builder: (context) =>  NotFound(),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, String pageName) {
    return MaterialPageRoute(
        builder: (context) => widget,
        //analytciste görülecek olan sayfa ismi için pageName veriyoruz
        settings: RouteSettings(name: pageName));
  }
}
