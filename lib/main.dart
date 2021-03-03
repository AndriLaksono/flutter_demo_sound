import 'package:flutter/material.dart';
import 'package:flutter_demo_sound/presentation/router/app_router.dart';
import './core/themes/app_theme.dart';
import './core/constants/strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      theme: AppTheme.normalTheme,
      initialRoute: AppRouter.home,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
