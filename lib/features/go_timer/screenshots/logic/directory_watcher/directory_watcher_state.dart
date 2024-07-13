part of 'directory_watcher_cubit.dart';

class DirectoryWatcherState extends Equatable {
  const DirectoryWatcherState();

  @override
  List<Object> get props => [];
}

class DirectoryWatcherInitial extends DirectoryWatcherState {}

class DirectoryWatcherLoaded extends DirectoryWatcherState {
  const DirectoryWatcherLoaded(this.imagePaths);
  final List<String> imagePaths;

  @override
  List<Object> get props => [imagePaths];
}

class DirectoryWatcherError extends DirectoryWatcherState {
  const DirectoryWatcherError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
