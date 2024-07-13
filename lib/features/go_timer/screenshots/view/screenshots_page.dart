import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_timer/features/go_timer/screenshots/logic/directory_watcher/directory_watcher_cubit.dart';
import 'package:go_timer/util/path_util.dart';

class ScreenshotsPage extends StatelessWidget {
  const ScreenshotsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DirectoryWatcherCubit(context.read<PathUtil>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Captured Screenshots'),
        ),
        body: BlocBuilder<DirectoryWatcherCubit, DirectoryWatcherState>(
          builder: (context, state) {
            if (state is DirectoryWatcherInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DirectoryWatcherLoaded) {
              if (state.imagePaths.isEmpty) {
                return const Center(
                    child: Text('No screenshots captured yet.'));
              } else {
                return ListView.builder(
                  itemCount: state.imagePaths.length,
                  itemBuilder: (context, index) {
                    final path = state.imagePaths[index];
                    return ListTile(
                      title: Text(path),
                      leading: Image.file(File(path), width: 50, height: 50),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ScreenshotDetailPage(imagePath: path),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            } else if (state is DirectoryWatcherError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}

class ScreenshotDetailPage extends StatelessWidget {
  final String imagePath;

  const ScreenshotDetailPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screenshot Detail'),
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
