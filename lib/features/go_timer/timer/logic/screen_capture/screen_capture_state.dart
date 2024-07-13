part of 'screen_capture_cubit.dart';

class ScreenCaptureState extends Equatable {
  final List<String> screenshotPaths;
  final bool isCapturing;

  const ScreenCaptureState({
    this.screenshotPaths = const [],
    this.isCapturing = false,
  });

  @override
  List<Object?> get props => [screenshotPaths, isCapturing];
}
