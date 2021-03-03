import 'package:flutter/material.dart';
import '../screens/sound_screen/sound.dart';
import '../screens/sound_screen/add_sound.dart';
import '../screens/home_screen/home.dart';
import '../../core/constants/strings.dart';
import '../../core/exceptions/route_exception.dart';

class AppRouter {
  static const String home = '/';
  static const String sound = '/sound';
  static const String add_sound = '/sound/add';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // args is data parameter if we want pass data to other screen
    final args = settings.arguments;
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
            builder: (_) => HomePage(title: Strings.appTitle));
      case sound:
        return MaterialPageRoute(
            builder: (_) => SoundPage(title: 'Sound Flutter'));
      case add_sound:
        return MaterialPageRoute(
            builder: (_) => AddSoundPage(title: 'Add Sound'));
      default:
        throw const RouteException('Route not found!');
      // return MaterialPageRoute(
      //     builder: (_) => Scaffold(
      //           appBar: AppBar(
      //             title: Text('Not found'),
      //           ),
      //           body: Center(
      //             child: Text('Error page not found'),
      //           ),
      //         ));
    }
  }
}
