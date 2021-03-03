import 'package:flutter/material.dart';
import '../../widgets/navigation_drawer.dart';

class SoundPage extends StatefulWidget {
  final String title;
  SoundPage({Key key, this.title}) : super(key: key);

  @override
  _SoundPageState createState() => _SoundPageState();
}

class _SoundPageState extends State<SoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sound Recorder'),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/sound/add');
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
        drawer: NavigationDrawer(),
        body: Center(
          child: Text('Sound Recorder'),
        ));
  }
}
