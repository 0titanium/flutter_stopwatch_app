import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stopwatch_app/presentation/stopwatch_screen.dart';
import 'package:flutter_stopwatch_app/presentation/stopwatch_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (_) => StopWatchViewModel(),
        child: const StopWatchScreen(),
      ),
    );
  }
}
