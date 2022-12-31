import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

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

  double? module, teeth, shift, angle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Container(
        child: Column(
          children: [
            TextBox(
              controller: moduleTextEditingController,
              foregroundDecoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide.none,
                ),
              ),
              header: '모듈(Module):',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  try {
                    module = double.parse(value) ?? null;
                  } catch(e) {
                    module = null;
                  }
                });
              },
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
              header: '잇수(Teeth):',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  try {
                    teeth = double.parse(value) ?? null;
                  } catch(e) {
                    teeth = null;
                  }
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextBox(
              controller: angleTextEditingController,
              foregroundDecoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide.none,
                ),
              ),
              header: '입력각(Angle):',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  try {
                    angle = double.parse(value) ?? null;
                  } catch(e) {
                    angle = null;
                  }
                });
              },
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
              header: '전위계수(Shift):',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  try {
                    shift = double.parse(value) ?? null;
                  } catch(e) {
                    shift = null;
                  }
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            FilledButton(
              child: Text('계산(Calculate)'),
              onPressed: () {
                showBottomSheet(
                  context: context,
                  builder: (context) {
                    return GearResult(module: module, teeth: teeth, angle: angle, shift: shift,);
                  },
                );
              },
              style: ButtonStyle(
                padding: ButtonState.all(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GearResult extends StatelessWidget {
  double? module, teeth, angle, shift;
  GearResult({required this.module, required this.teeth, required this.angle, required this.shift});

  @override
  Widget build(BuildContext context) {
    double? pitchDiameter, shiftedPitchDiameter, outerDiameter, innerDiameter, contactWidth, invalute, tolMin, tolMax, undercut, frontPressureAngle;
    int? contactNumber;
    const double helixAngle = 0.0;
    const double toRad = pi / 180;

    return Container(
      height: 250,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: () {
          if (module == null || teeth == null || angle == null || shift == null) {
            return Text("입력이 잘못되었습니다. 다시 입력해 주십시오.\n(Invalid input. Please enter again.)");
          } else {
            pitchDiameter = module! * teeth! / cos(helixAngle * toRad);
            shiftedPitchDiameter = pitchDiameter! + ( shift! * module! ) * 2;
            outerDiameter = ( teeth! / cos(helixAngle*pi/180) + 2 * ( 1 + shift!) ) * module!;
            innerDiameter = shiftedPitchDiameter! - 2 * ( 1.25 * module! );
            contactNumber = (angle! / 180 * teeth! + 0.5).floor();
            frontPressureAngle = atan(tan(angle!*toRad)/cos(helixAngle*toRad));
            invalute = tan(frontPressureAngle!) - frontPressureAngle!;
            contactWidth = module! * cos(angle!*toRad) * ( pi*(contactNumber!.toDouble() - 0.5) + teeth!*invalute!) + 2 * shift! * module! * sin(angle!*toRad);
            tolMin = -0.05 * module!;
            tolMax = -0.05 * module! - 0.08;

            undercut = (2 * (1 - shift!) / pow(sin(angle!*toRad),2)) * pow(cos(helixAngle*toRad),3);
            return Column(
              children: [
                Text("기준 피치원 지름: " + pitchDiameter.toString(),),
                SizedBox(height: 10),
                Text("이끝원 지름: " + outerDiameter.toString()),
                SizedBox(height: 10),
                Text("이뿌리 지름: " + innerDiameter.toString()),
                SizedBox(height: 10),
                Text("걸치기 잇수: " + contactNumber.toString()),
                SizedBox(height: 10),
                Text("걸치기 두께: " + contactWidth!.toStringAsFixed(3)),
                SizedBox(height: 10),
                Text("걸치기 두께 공차: " + tolMin!.toStringAsFixed(2) + "/" +tolMax!.toStringAsFixed(2)),
                SizedBox(height: 10),
                Text("언더컷 한계 잇수: " + undercut!.toStringAsFixed(1)),
                if (teeth! < undercut!) Text("기어 잇수가 언더컷 한계 잇수보다 작습니다!", style: TextStyle(color: Colors.warningPrimaryColor),),
              ],
            );
          }
        }(),
      ),
    );
  }
}