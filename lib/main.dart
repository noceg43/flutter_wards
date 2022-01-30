import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final androidConfig = const FlutterBackgroundAndroidConfig(
    notificationTitle: "flutter_background example app",
    notificationText: "Background notification for keeping the example app running in the background",
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon: AndroidResource(name: 'background_icon', defType: 'drawable'), // Default is ic_launcher from folder mipmap
  );

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        body: AnimatedGradient()
        ),
      );
  }
}

class AnimatedGradient extends StatefulWidget {
  const AnimatedGradient({Key? key}) : super(key: key);

  @override
  _AnimatedGradientState createState() => _AnimatedGradientState();
}

class _AnimatedGradientState extends State<AnimatedGradient> {


  List<Color> colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow
  ];
  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];
  int index = 0;
  Color bottomColor = Colors.red;
  Color topColor = Colors.yellow;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;
  @override

  @override
  void initState() {
    super.initState();
    // Rebuild the screen after 3s which will process the animation from green to blue
    Future.delayed(Duration(seconds: 1)).then((value) => setState(() {
      bottomColor = Colors.blue;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 2),
              onEnd: () {
                setState(() {
                  index = index + 1;
                  // animate the color
                  bottomColor = colorList[index % colorList.length];
                  topColor = colorList[(index + 1) % colorList.length];

                  //// animate the alignment
                   begin = alignmentList[index % alignmentList.length];
                   end = alignmentList[(index + 2) % alignmentList.length];
                   bottomColor = Colors.blue;
                });
              },
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: begin, end: end, colors: [bottomColor, topColor])),
            ),

            Center  (
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.transparent,
                    side: BorderSide(color: Colors.white.withOpacity(1), width: 15),

                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(75),
                    ),
                ),
                onPressed: () {
                  _launchURLS();
                },
                child: Icon(
                  Icons.search_rounded,
                  size: 250,
                  color: Colors.white.withOpacity(0.8),
                )
              ),
            )

          ],
        ));
  }

}









_launchURLS() async {
  FlutterBackground.enableBackgroundExecution();
  var words = generateWordPairs().take(35);
  String url;
  for(var i in words) {
    // "https://www.google.com/search?q="
    // "https://www.bing.com/search?q="
    url = "https://www.bing.com/search?q=" + i.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url)';
    }
  }
}
