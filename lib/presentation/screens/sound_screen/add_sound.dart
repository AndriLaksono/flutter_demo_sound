import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddSoundPage extends StatefulWidget {
  final String title;
  AddSoundPage({Key key, this.title}) : super(key: key);

  @override
  _AddSoundPageState createState() => _AddSoundPageState();
}

typedef _Fn = void Function();

class _AddSoundPageState extends State<AddSoundPage> {
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;

  final _titleController = TextEditingController();

  @override
  void initState() {
    _mPlayer.openAudioSession().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
    super.initState();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder.openAudioSession();
    _mRecorderIsInited = true;
  }

  @override
  void dispose() {
    _mPlayer.closeAudioSession();
    _mPlayer = null;
    _mRecorder.closeAudioSession();
    _mRecorder = null;
    super.dispose();
  }

  // ============ Function for record and play ============ //
  void record() async {
    var tempDir = await syspath.getApplicationDocumentsDirectory();
    String _audioPath = '${tempDir.path}/audio_sound.aac';
    _mRecorder.startRecorder(toFile: _audioPath).then((value) {
      setState(() {});
    });
  }

  void stopRecorder() async {
    await _mRecorder.stopRecorder().then((value) async {
      setState(() {
        _mplaybackReady = true;
      });
    });
  }

  void play() async {
    var tempDir = await syspath.getApplicationDocumentsDirectory();
    String _audioPath = '${tempDir.path}/audio_sound.aac';
    // asset to check if all condition is true
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder.isStopped &&
        _mPlayer.isStopped);
    // start player
    _mPlayer
        .startPlayer(
            fromURI: _audioPath,
            whenFinished: () {
              setState(() {});
            })
        .then((value) => setState(() {}));
  }

  void stopPlayer() {
    _mPlayer.stopPlayer().then((value) => setState(() {}));
  }

  // ======================== UI Function ======================== //
  _Fn getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer.isStopped) {
      return null;
    }
    return _mRecorder.isStopped ? record : stopRecorder;
  }

  _Fn getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder.isStopped) {
      return null;
    }
    return _mPlayer.isStopped ? play : stopPlayer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(3),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: getRecorderFn(),
                            child: Text(
                                _mRecorder.isRecording ? 'Stop' : 'Record'),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(_mRecorder.isRecording
                              ? 'Recording in progress'
                              : 'Recorder is stopped'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(3),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: getPlaybackFn(),
                            child:
                                Text(_mRecorder.isRecording ? 'Stop' : 'Play'),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(_mPlayer.isPlaying
                              ? 'Playback in progress'
                              : 'Player is stopped'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Save'),
            onPressed: () {
              Fluttertoast.showToast(
                  msg: "Saved",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          )
        ],
      ),
    );
  }
}
