import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/home_screen.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/utility/styles/style.dart';

void main() {
  /// Custom error page
  if (kReleaseMode) {
    ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
      debugPrint(flutterErrorDetails.toString());
      return Material(
        child: Center(
            child: Text(
          "An unhandled error occurred\nplease notify the developer",
          textAlign: TextAlign.center,
        )),
      );
    };
  }
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mimicking the Ticktok video feature',
    theme: ThemeData(
        brightness: Brightness.dark,
        hintColor: Colors.white,
        accentColor: Colors.white,
        primaryColor: ColorPlate.orange,
        primaryColorBrightness: Brightness.dark,
        scaffoldBackgroundColor: ColorPlate.back1,
        dialogBackgroundColor: ColorPlate.back2,
        accentColorBrightness: Brightness.light,
        textTheme: TextTheme(
          bodyText1: StandardTextStyle.normal,
        ),
      ), 
      home: HomePage(),
      
    );
  }
}