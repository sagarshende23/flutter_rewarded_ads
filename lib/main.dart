import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

const testDevices = "Your_DEVICE_ID";

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevices != null ? <String>['testDevices'] : null,
    keywords: <String>['Book', 'Game'],
    nonPersonalizedAds: true,
  );

  int _coins = 0;
  RewardedVideoAd videoAd = RewardedVideoAd.instance;

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);

    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("REWARDED VIDEO AD $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          _coins += rewardAmount;
        });
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Rewarded Video Ad example'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('LOAD REWARDED VIDEO AD'),
              RaisedButton(
                child: Text("LOAD REWARDED AD"),
                onPressed: () {
                  videoAd.load(
                      adUnitId: RewardedVideoAd.testAdUnitId,
                      targetingInfo: targetingInfo);
                },
              ),
              RaisedButton(
                child: Text("SHOW REWARDED VIDEOAD"),
                onPressed: () {
                  videoAd.show();
                },
              ),
              Text("YOU HAVE $_coins coins"),
            ],
          ),
        ),
      ),
    );
  }
}
