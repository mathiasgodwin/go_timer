import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_timer/features/go_timer/timer/logic/screen_capture/screen_capture_cubit.dart';
import 'package:go_timer/features/go_timer/timer/logic/timer/timer_cubit.dart';
import 'package:go_timer/features/go_timer/timer/view/timer_page.dart';
import 'package:go_timer/util/path_util.dart';
import 'package:go_timer/util/theme_util.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PathUtil(),
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, "Montserrat", "Montserrat");

    final theme = MaterialTheme(textTheme);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TimerCubit(),
        ),
        BlocProvider(
          create: (context) => ScreenCaptureCubit(context.read<PathUtil>()),
        ),
      ],
      child: MaterialApp(
        darkTheme: theme.dark(),
        debugShowCheckedModeBanner: false,
        highContrastDarkTheme: theme.darkHighContrast(),
        highContrastTheme: theme.lightHighContrast(),
        theme: theme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const TimerPage(),
      ),
    );
  }
}
