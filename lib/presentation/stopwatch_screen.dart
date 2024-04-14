import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Timer? _timer;
  int _time = 0;
  bool _isRunning = false;

  final List<dynamic> _labTimes = [];

  void _clickButton() {
    _isRunning = !_isRunning;

    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  void _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  void _pause() {
    _timer?.cancel();
  }

  void _recordLabTime(String time) {
    _labTimes.insert(0, [_labTimes.length + 1, time]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String min = '${(_time ~/ (100 * 60)) % 60}'.padLeft(2, '0');
    String sec = '${(_time ~/ 100) % 60}'.padLeft(2, '0');
    String hundredth = '${_time % 100}'.padLeft(2, '0');

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 170,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$min:',
                style: const TextStyle(fontSize: 80, color: Colors.greenAccent),
              ),
              Text(
                '$sec.',
                style: const TextStyle(fontSize: 80, color: Colors.greenAccent),
              ),
              Text(
                hundredth,
                style: const TextStyle(fontSize: 80, color: Colors.greenAccent),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _isRunning == false
                  ? const FloatingActionButton.large(
                      shape: CircleBorder(eccentricity: 0.1),
                      backgroundColor: Colors.grey,
                      onPressed: null,
                      child: Text('Lab'),
                    )
                  : FloatingActionButton.large(
                      shape: const CircleBorder(eccentricity: 0.1),
                      backgroundColor: Colors.grey,
                      onPressed: () {
                        setState(() {
                          _recordLabTime('$min:$sec.$hundredth');
                        });
                      },
                      child: const Text('Lab'),
                    ),
              const SizedBox(
                width: 30,
              ),
              FloatingActionButton.large(
                shape: const CircleBorder(eccentricity: 0.1),
                backgroundColor: _isRunning ? Colors.redAccent : Colors.green,
                onPressed: () {
                  setState(() {
                    _clickButton();
                  });
                },
                child: _isRunning ? const Text('Stop') : const Text('Start'),
              ),
            ],
          ),
          SizedBox(
            height: 300,
            child: ListView(
                children: _labTimes
                    .map((time) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              ' 랩 ${time[0]} ',
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              time[1],
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ))
                    .toList()),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.timer),
      //       label: '스톱워치',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.av_timer),
      //       label: '타이머',
      //     ),
      //   ],
      // ),
    );
  }
}
