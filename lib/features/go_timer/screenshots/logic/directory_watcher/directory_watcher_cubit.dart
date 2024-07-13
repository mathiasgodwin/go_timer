import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:go_timer/util/path_util.dart';

part 'directory_watcher_state.dart';

class DirectoryWatcherCubit extends Cubit<DirectoryWatcherState> {
  final PathUtil pathUtil;
  StreamSubscription<FileSystemEvent>? _directorySubscription;

  DirectoryWatcherCubit(this.pathUtil) : super(DirectoryWatcherInitial()) {
    _startWatching();
    _loadInitialFiles();
  }

  void _startWatching() async {
    final path = await pathUtil.getScreenshotPath();

    final directory = Directory(path);
    _directorySubscription = directory.watch().listen((event) {
      if (event is FileSystemCreateEvent ||
          event is FileSystemModifyEvent ||
          event is FileSystemDeleteEvent) {
        _loadFiles();
      }
    });
  }

  void _loadInitialFiles() {
    _loadFiles();
  }

  void _loadFiles() async {
    final path = await pathUtil.getScreenshotPath();

    final directory = Directory(path);
    if (await directory.exists()) {
      final files = directory
          .listSync()
          .where((item) => item is File && _isImageFile(item.path))
          .map((item) => item.path)
          .toList();
      emit(DirectoryWatcherLoaded(files));
    } else {
      emit(DirectoryWatcherError("Directory does not exist"));
    }
  }

  bool _isImageFile(String path) {
    final extensions = ['.jpg', '.jpeg', '.png', '.gif'];
    return extensions.any((ext) => path.toLowerCase().endsWith(ext));
  }

  @override
  Future<void> close() {
    _directorySubscription?.cancel();
    return super.close();
  }
}
