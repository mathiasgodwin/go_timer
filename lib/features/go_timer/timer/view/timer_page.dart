import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_timer/features/go_timer/screenshots/view/screenshots_page.dart';
import 'package:go_timer/features/go_timer/timer/logic/screen_capture/screen_capture_cubit.dart';
import 'package:go_timer/features/go_timer/timer/logic/timer/timer_cubit.dart';
import 'package:go_timer/features/go_timer/timer/logic/widgets/camera_widget.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  void initState() {
    super.initState();
    // Start the timer if it was running before the app closed
    if (context.read<TimerCubit>().state.isRunning) {
      context.read<TimerCubit>().startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TimerCubit, TimerState>(
      listener: (context, state) {
        if (state.capture) {
          context.read<ScreenCaptureCubit>().captureScreen();
        }
      },
      child: Scaffold(
        bottomNavigationBar: const SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              CameraWidget(),
              SizedBox(
                width: 30,
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Timer App'),
        ),
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    width: 600,
                    child: Card.outlined(
                      elevation: 2,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 30,
                          ),
                          const _CountDownTimer(),
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              FilledButton(
                                onPressed: () {
                                  BlocProvider.of<TimerCubit>(context)
                                      .startTimer();
                                },
                                child: const Text('Start Timer'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<TimerCubit>(context)
                                      .stopTimer();
                                },
                                child: const Text('Stop Timer'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<TimerCubit>(context)
                                      .resetTimer();
                                },
                                child: const Text('Reset Timer'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ///

                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenshotsPage()),
                      );
                    },
                    child: const Text('View Screenshots'),
                  ),
                ),
                BlocBuilder<ScreenCaptureCubit, ScreenCaptureState>(
                  builder: (context, state) {
                    if (state.isCapturing) {
                      return const CircularProgressIndicator();
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CountDownTimer extends StatelessWidget {
  const _CountDownTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        final duration = Duration(seconds: state.duration);
        final hours = duration.inHours.toString().padLeft(2, '0');
        final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
        final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

        return Text(
          '$hours:$minutes:$seconds',
          style: Theme.of(context).textTheme.displayLarge,
        );
      },
    );
  }
}
