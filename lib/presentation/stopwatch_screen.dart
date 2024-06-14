import 'package:flutter/material.dart';
import 'package:flutter_stopwatch_app/presentation/stopwatch_view_model.dart';
import 'package:provider/provider.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StopWatchViewModel>();

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
                '${viewModel.min}:',
                style: const TextStyle(fontSize: 80, color: Colors.greenAccent),
              ),
              Text(
                '${viewModel.sec}.',
                style: const TextStyle(fontSize: 80, color: Colors.greenAccent),
              ),
              Text(
                viewModel.hundredth,
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
              viewModel.hasStarted == false
                  ? const FloatingActionButton.large(
                      shape: CircleBorder(eccentricity: 0.1),
                      backgroundColor: Colors.grey,
                      onPressed: null,
                      child: Text('Lab'),
                    )
                  : viewModel.isRunning
                      ? FloatingActionButton.large(
                          shape: const CircleBorder(eccentricity: 0.1),
                          backgroundColor: Colors.grey,
                          onPressed: () {
                            setState(() {
                              viewModel.recordLabTime(
                                  '${viewModel.min}:${viewModel.sec}.${viewModel.hundredth}');
                            });
                          },
                          child: const Text('Lab'),
                        )
                      : FloatingActionButton.large(
                          shape: const CircleBorder(eccentricity: 0.1),
                          backgroundColor: Colors.grey,
                          onPressed: () {
                            setState(() {
                              viewModel.reset();
                            });
                          },
                          child: const Text('Reset'),
                        ),
              const SizedBox(
                width: 30,
              ),
              FloatingActionButton.large(
                shape: const CircleBorder(eccentricity: 0.1),
                backgroundColor:
                    viewModel.isRunning ? Colors.redAccent : Colors.green,
                onPressed: () {
                  viewModel.clickButton();
                },
                child: viewModel.isRunning
                    ? const Text('Stop')
                    : const Text('Start'),
              ),
            ],
          ),
          SizedBox(
            height: 300,
            child: ListView(
                children: viewModel.labTimes
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
    );
  }
}
