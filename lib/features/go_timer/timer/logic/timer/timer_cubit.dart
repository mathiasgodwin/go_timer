import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'timer_state.dart';

class TimerCubit extends HydratedCubit<TimerState> {
  TimerCubit() : super(const TimerState(duration: 0));
  Timer? _timer;

  void startTimer() {
    if (state.isRunning) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      tick();
    });
    emit(TimerState(duration: state.duration, isRunning: true, capture: false));
  }

  void stopTimer() {
    _timer?.cancel();
    emit(
        TimerState(duration: state.duration, isRunning: false, capture: false));
  }

  void resetTimer() {
    _timer?.cancel();
    emit(const TimerState(duration: 0, isRunning: false, capture: false));
  }

  void tick() {
    bool shouldCapture = false;
    final newDuration = state.duration + 1;

    if (newDuration % 5 == 0) {
      shouldCapture = true;
    }

    emit(TimerState(
        duration: newDuration, isRunning: true, capture: shouldCapture));
  }

  @override
  TimerState fromJson(Map<String, dynamic> json) {
    return TimerState(
      duration: json['duration'] as int,
      isRunning: json['isRunning'] as bool,
    );
  }

  @override
  Map<String, dynamic> toJson(TimerState state) {
    return {
      'duration': state.duration,
      'isRunning': state.isRunning,
    };
  }
}
