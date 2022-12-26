import 'package:fluent_ui/fluent_ui.dart';

class GearScreen extends StatefulWidget {
  const GearScreen({Key? key}) : super(key: key);

  @override
  State<GearScreen> createState() => _GearScreenState();
}

class _GearScreenState extends State<GearScreen> {
  TextEditingController moduleTextEditingController = TextEditingController();
  TextEditingController teethTextEditingController = TextEditingController();
  TextEditingController shiftTextEditingController = TextEditingController();
  TextEditingController angleTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextBox(
                        controller: moduleTextEditingController,
                        foregroundDecoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide.none,
                          ),
                        ),
                        header: 'Module:',
                        placeholder: 'Default value is 1.',
                        expands: false,
                        initialValue: '1',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextBox(
                        controller: teethTextEditingController,
                        foregroundDecoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide.none,
                          ),
                        ),
                        header: 'Teeth:',
                        placeholder: 'Default value is 20.',
                        expands: false,
                        initialValue: '20',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      TextBox(
                        controller: angleTextEditingController,
                        foregroundDecoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide.none,
                          ),
                        ),
                        header: 'Angle:',
                        placeholder: 'Default value is 20.',
                        expands: false,
                        initialValue: '20',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextBox(
                        controller: shiftTextEditingController,
                        foregroundDecoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide.none,
                          ),
                        ),
                        header: 'Shift:',
                        placeholder: 'Default value is 0.',
                        expands: false,
                        initialValue: '0',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            FilledButton(
              child: Text('Calculate'),
              onPressed: () {},
              style: ButtonStyle(
                padding: ButtonState.all(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
