import 'package:flutter/material.dart';
import '../../core/constants/strings.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(
                color: Colors.amber,
                image: DecorationImage(
                    image: AssetImage(Strings.logoDrawer), fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.play_circle_fill),
            title: Text('Sound'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed('/sound');
            },
          )
        ],
      ),
    );
  }
}
