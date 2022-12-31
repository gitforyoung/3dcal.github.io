import 'package:flutter/foundation.dart';
import 'package:mechanical_calculator/screens/gear_screen.dart';
import 'package:mechanical_calculator/screens/spring_screen.dart';
import 'package:window_manager/window_manager.dart';
import 'package:fluent_ui/fluent_ui.dart';

const String appTitle = 'Mechanical Calculator';

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  if (isDesktop) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    const double width = 600;
    const double height = 600;

    WindowOptions windowOptions = const WindowOptions(
      size: Size(width, height),
      center: true,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      minimumSize: Size(width, height),
      maximumSize: Size(width, height),
    );

    windowManager.waitUntilReadyToShow(
      windowOptions,
      () async {
        await windowManager.show();
        await windowManager.focus();
      },
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      theme: ThemeData(fontFamily: "NanumSquareRound"),
      home: NavigationView(
        appBar: NavigationAppBar(
          automaticallyImplyLeading: false,
          title: () {
            if (kIsWeb) {
              return const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(appTitle),
              );
            }
            return const DragToMoveArea(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(appTitle),
              ),
            );
          }(),
          actions: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isDesktop
                  ? const WindowButtons()
                  : Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(FluentIcons.calculator_group),
                      ),
                    ),
            ],
          ),
        ),
        pane: NavigationPane(
          selected: index,
          onChanged: (newIndex) {
            setState(
              () {
                index = newIndex;
              },
            );
          },
          displayMode: PaneDisplayMode.minimal,
          items: [
            PaneItem(
              title: Text(
                "Gear Calculator",
                // style: TextStyle(fontWeight: FontWeight.bold),
              ),
              icon: Icon(FluentIcons.settings),
              body: GearScreen(),
            ),
            PaneItem(
              title: Text(
                "Spring Calculator",
                // style: TextStyle(fontWeight: FontWeight.bold),
              ),
              icon: Icon(FluentIcons.charticulator_order_row),
              body: SpringScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
