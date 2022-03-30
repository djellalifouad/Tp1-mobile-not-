import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'models/tweet.model.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TweetDetails extends StatefulWidget {
  Tweet tweet;
  TweetDetails(this.tweet);

  @override
  State<TweetDetails> createState() => _TweetDetailsState();
}

class _TweetDetailsState extends State<TweetDetails>
    with WidgetsBindingObserver {
  final FlutterTts tts = FlutterTts();

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        tts.stop();
        break;
      case AppLifecycleState.resumed:
        break;
        break;
    }
  }

  @override
  void dispose() {
    tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Tweet sans bdd"),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Image.asset(
                'assets/Twitter_Bird.png',
                height: 30,
                width: 30,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 40,
          ),
          Image.asset(
            'assets/Twitter_Bird.png',
            height: 100,
            width: 100,
          ),
          SizedBox(
            height: 10,
          ),
          Text(widget.tweet.date.substring(0, 16)),
          SizedBox(
            height: 10,
          ),
          Text(widget.tweet.title),
          SizedBox(
            height: 10,
          ),
          Text(widget.tweet.name),
          SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () {
                tts.speak(this.widget.tweet.title);
              },
              child: Icon(Icons.play_arrow_rounded))
        ]),
      ),
    );
  }
}
