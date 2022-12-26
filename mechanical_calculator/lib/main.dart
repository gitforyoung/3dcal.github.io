import 'package:mechanical_calculator/screens/gear_screen.dart';
import 'package:mechanical_calculator/screens/spring_screen.dart';
import 'package:window_manager/window_manager.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  const double width = 600;
  const double height = 600;

  WindowOptions windowOptions = const WindowOptions(
    size: Size(width, height),
    center: true,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
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
        pane: NavigationPane(
          selected: index,
          onChanged: (newIndex) {
            setState(
              () {
                index = newIndex;
              },
            );
          },
          displayMode: PaneDisplayMode.compact,
          header: Text(
            "Calculators",
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          items: [
            PaneItem(
              title: Text(
                "Gear Calculator",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              icon: Icon(FluentIcons.settings),
              body: GearScreen(),
            ),
            PaneItem(
              title: Text(
                "Spring Calculator",
                style: TextStyle(fontWeight: FontWeight.bold),
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
