import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_timer/util/path_util.dart';
import 'package:screen_capturer/screen_capturer.dart';

part 'screen_capture_state.dart';

class ScreenCaptureCubit extends Cubit<ScreenCaptureState> {
  final PathUtil pathUtil;
  ScreenCaptureCubit(this.pathUtil) : super(const ScreenCaptureState());

  Future<void> captureScreen() async {
    emit(ScreenCaptureState(
      screenshotPaths: state.screenshotPaths,
      isCapturing: true,
    ));

    try {
      final path = await pathUtil.getScreenshotPath();
      final fullPath =
          '${path}screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
      await ScreenCapturer.instance.capture(
        mode: CaptureMode.screen,
        imagePath: fullPath,
        copyToClipboard: false,
        silent: false,
      );

      final updatedPaths = List<String>.from(state.screenshotPaths)
        ..add(fullPath);
      emit(ScreenCaptureState(
        screenshotPaths: updatedPaths,
        isCapturing: false,
      ));
    } catch (e) {
      emit(ScreenCaptureState(
        screenshotPaths: state.screenshotPaths,
        isCapturing: false,
      ));
    }
  }
}
