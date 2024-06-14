import 'dart:async';

import 'package:flutter/cupertino.dart';

class StopWatchViewModel with ChangeNotifier {
  Timer? _timer;
  int _time = 0;
  bool _isRunning = false;
  bool _hasStarted = false;
  final List<dynamic> _labTimes = [];
  String _min = '00';
  String _sec = '00';
  String _hundredth = '00';

  bool get isRunning => _isRunning;

  bool get hasStarted => _hasStarted;

  List<dynamic> get labTimes => _labTimes;

  String get sec => _sec;

  String get min => _min;

  String get hundredth => _hundredth;

  void clickButton() {
    _isRunning = !_isRunning;

    if (isRunning) {
      start();
    } else {
      pause();
    }
  }

  void start() {
    _hasStarted = true;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _time++;
      _min = '${(_time ~/ (100 * 60)) % 60}'.padLeft(2, '0');
      _sec = '${(_time ~/ 100) % 60}'.padLeft(2, '0');
      _hundredth = '${_time % 100}'.padLeft(2, '0');

      notifyListeners();
    });
  }

  void pause() {
    _timer?.cancel();
  }

  void reset() {
    _isRunning = false;
    _hasStarted = false;
    _timer?.cancel();
    _labTimes.clear();
    _time = 0;

    debugPrint('$_min:$_sec:$_hundredth');

    notifyListeners();
  }

  void recordLabTime(String time) {
    _labTimes.insert(0, [_labTimes.length + 1, time]);
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }
}
