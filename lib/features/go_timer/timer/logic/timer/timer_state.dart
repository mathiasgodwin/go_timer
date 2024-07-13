part of 'timer_cubit.dart';

class TimerState extends Equatable {
  final int duration;
  final bool isRunning;
  final bool capture;

  const TimerState(
      {required this.duration, this.isRunning = false, this.capture = false});

  @override
  List<Object> get props => [duration, isRunning, capture];

  TimerState copyWith({
    int? duration,
    bool? isRunning,
    bool? capture,
  }) {
    return TimerState(
      duration: duration ?? this.duration,
      isRunning: isRunning ?? this.isRunning,
      capture: capture ?? this.capture,
    );
  }
}
