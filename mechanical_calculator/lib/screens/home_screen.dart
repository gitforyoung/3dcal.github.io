import 'package:fluent_ui/fluent_ui.dart';
import 'package:mechanical_calculator/screens/gear_screen.dart';
import 'package:mechanical_calculator/screens/spring_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
        title: Text('Mechanical Calculator'),
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
        displayMode: PaneDisplayMode.compact,
        header: Text("Calculators"),
        items: [
          PaneItem(
            title: Text("Gear Calculator"),
            icon: Icon(FluentIcons.settings),
            body: GearScreen(),
          ),
          PaneItem(
            title: Text("Spring Calculator"),
            icon: Icon(FluentIcons.charticulator_order_row),
            body: SpringScreen(),
          ),
        ],
      ),
    );
  }
}
