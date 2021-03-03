import 'package:flutter/material.dart';
import '../../widgets/navigation_drawer.dart';

class HomePage extends StatelessWidget {
  final String title;
  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Home'),
      ),
      drawer: NavigationDrawer(),
    );
  }
}
