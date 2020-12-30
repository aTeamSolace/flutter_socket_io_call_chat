import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket_io_chat_call/AllChatsPage.dart';
import 'package:flutter_socket_io_chat_call/Chat.dart';
import 'package:flutter_socket_io_chat_call/Constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool joined = false;
  int remoteUid = null;
  RtcEngine engine;
  bool isCalling = false;
  var userId;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Flutter Socket IO chat call'),
      ),
      body: isCalling == true
          ? Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.only(bottom: 20.0),
              child: Stack(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Call Started",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            isCalling = false;
                          });
                          await engine.leaveChannel();
                        },
                        child: Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                          child: Icon(
                            Icons.call_end_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  onTap: () async {
                    setState(() {
                      isCalling = true;
                    });
                    await engine.joinChannel(
                        Constant.Token, 'test_shubham', null, 0);
                  },
                  focusColor: Colors.red,
                  leading: Icon(
                    Icons.call,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Please Connect!',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Container(
                  height: 20,
                ),
                ListTile(
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Chat()));
                  },
                  focusColor: Colors.red,
                  leading: Icon(
                    Icons.message,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Send Message!',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> initPlatformState() async {
    engine = await RtcEngine.create(Constant.APP_ID);
    engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          setState(() {
            joined = true;
            userId = uid;
          });
        },
        userJoined: (int uid, int elapsed) {
          setState(() {
            remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          setState(() {
            remoteUid = null;
          });
        },
      ),
    );
  }
}
