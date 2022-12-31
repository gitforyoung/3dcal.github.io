import 'dart:math';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:mechanical_calculator/reference/spring_strength.dart';

String? selectedMaterial;

class SpringScreen extends StatefulWidget {
  const SpringScreen({Key? key}) : super(key: key);

  @override
  State<SpringScreen> createState() => _SpringScreenState();
}

class _SpringScreenState extends State<SpringScreen> {
  double? wireDiameter,
      coilInnerDiameter,
      effectiveTurns,
      endTurns,
      freeLength,
      selectedLengthA,
      selectedLengthB;
  bool endCut = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Container(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("재질: "),
                          SizedBox(height: 2,),
                          ComboBox<String>(
                            isExpanded: true,
                            popupColor: Colors.blue,
                            placeholder: const Text('재질 선택'),
                            value: selectedMaterial,
                            items: springMaterial.map((e) {
                              return ComboBoxItem(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedMaterial = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("양끝 연마: "),
                          Row(
                            children: [
                              ToggleSwitch(checked: endCut, onChanged: (value){
                                setState(() {
                                  endCut = value;
                                });
                              }),
                              SizedBox(width: 10),
                              Text(endCut ? "함" : "안함", style: TextStyle(color: Colors.blue),),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("선경:"),
                          SizedBox(height: 2,),
                          ComboBox<String>(
                            isExpanded: true,
                            popupColor: Colors.blue,
                            placeholder: const Text('선경 선택'),
                            value: wireDiameter.toString(),
                            items: springSizeList.map((e) {
                              return ComboBoxItem(
                                child: Text(e.toString()),
                                value: e.toString(),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                wireDiameter = double.parse(value!);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextBox(
                        foregroundDecoration: BoxDecoration(
                          border: Border(bottom: BorderSide.none),
                        ),
                        header: '코일 내경:',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            try {
                              coilInnerDiameter = double.parse(value) ?? null;
                            } catch (e) {
                              coilInnerDiameter = null;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextBox(
                        foregroundDecoration: BoxDecoration(
                          border: Border(bottom: BorderSide.none),
                        ),
                        header: '유효 감김수:',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            try {
                              effectiveTurns = double.parse(value) ?? null;
                            } catch (e) {
                              effectiveTurns = null;
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextBox(
                        foregroundDecoration: BoxDecoration(
                          border: Border(bottom: BorderSide.none),
                        ),
                        header: '자리 감김수:',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            try {
                              endTurns = double.parse(value) ?? null;
                            } catch (e) {
                              endTurns = null;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextBox(
                  foregroundDecoration: BoxDecoration(
                    border: Border(bottom: BorderSide.none),
                  ),
                  header: '자유 길이:',
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      try {
                        freeLength = double.parse(value) ?? null;
                      } catch (e) {
                        freeLength = null;
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextBox(
                        foregroundDecoration: BoxDecoration(
                          border: Border(bottom: BorderSide.none),
                        ),
                        header: '지정 길이 A:',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            try {
                              selectedLengthA = double.parse(value) ?? null;
                            } catch (e) {
                              selectedLengthA = null;
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextBox(
                        foregroundDecoration: BoxDecoration(
                          border: Border(bottom: BorderSide.none),
                        ),
                        header: '지정 길이 B:',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            try {
                              selectedLengthB = double.parse(value) ?? null;
                            } catch (e) {
                              selectedLengthB = null;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            FilledButton(
              child: Text('계산(Calculate)'),
              onPressed: () {
                showBottomSheet(
                  context: context,
                  builder: (context) {
                    return SpringResult(
                        wireDiameter,
                        coilInnerDiameter,
                        effectiveTurns,
                        endTurns,
                        freeLength,
                        selectedLengthA,
                        selectedLengthB,
                        endCut);
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

  static const springMaterial = <String>[
    "SWP-A",
    "SWP-B",
    "SWP-C",
    "SUS304-WPB",
    "C5191W-H"
  ];
}

class SpringResult extends StatelessWidget {
  double? wireDiameter,
      coilInnerDiameter,
      effectiveTurns,
      endTurns,
      freeLength,
      selectedLengthA,
      selectedLengthB;
  late bool endCut;

  SpringResult(
      double? wireDiameter,
      double? coilInnerDiameter,
      double? effectiveTurns,
      double? endTurns,
      double? freeLength,
      double? selectedLengthA,
      double? selectedLengthB,
      bool endCut) {
    this.wireDiameter = wireDiameter;
    this.coilInnerDiameter = coilInnerDiameter;
    this.effectiveTurns = effectiveTurns;
    this.endTurns = endTurns;
    this.freeLength = freeLength;
    this.selectedLengthA = selectedLengthA;
    this.selectedLengthB = selectedLengthB;
    this.endCut = endCut;
  }

  @override
  Widget build(BuildContext context) {
    late double minLength,
        angle,
        ratio,
        coefficient,
        forceA,
        forceB,
        strengthA,
        strengthB,
        minStrength,
        maxStrength;
    late int lifeTime;
    late String tensileStrength;

    return Container(
      height: 400,
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
          if (wireDiameter == null ||
              coilInnerDiameter == null ||
              effectiveTurns == null ||
              endTurns == null ||
              freeLength == null ||
              selectedLengthA == null ||
              selectedLengthB == null) {
            return Text(
                "입력이 잘못되었습니다. 다시 입력해 주십시오.\n(Invalid input. Please enter again.)");
          } else {
            if (endCut) {
              minLength = wireDiameter! * (effectiveTurns! + endTurns!);
            } else {
              minLength = wireDiameter! * (effectiveTurns! + endTurns! + 1);
            }
            double pitch =
                (freeLength! - minLength) / effectiveTurns! + wireDiameter!;
            angle = atan(pitch / (pi * (coilInnerDiameter! + wireDiameter!))) *
                180 /
                pi;
            ratio = (coilInnerDiameter! + wireDiameter!) / wireDiameter!;
            late double gFactor;
            if (selectedMaterial == "SWP-A" ||
                selectedMaterial == "SWP-B" ||
                selectedMaterial == "SWP-C") {
              gFactor = 8000;
            } else if (selectedMaterial == "SUS304-WPB") {
              gFactor = 7000;
            } else if (selectedMaterial == "C5191W-H") {
              gFactor = 4300;
            }
            coefficient = pow(wireDiameter!, 4) *
                gFactor /
                (8 *
                    effectiveTurns! *
                    pow((wireDiameter! + coilInnerDiameter!), 3)) *
                9.80665;
            for (int i = 0; i <= (springSizeList.length - 1); i++) {
              if (wireDiameter == springSizeList[i]) {
                if (selectedMaterial == "SWP-A") {
                  minStrength = swpa[i][0].toDouble();
                  maxStrength = swpa[i][1].toDouble();
                  break;
                } else if (selectedMaterial == "SWP-B") {
                  minStrength = swpb[i][0].toDouble();
                  maxStrength = swpb[i][1].toDouble();
                  break;
                } else if (selectedMaterial == "SWP-C") {
                  minStrength = swpc[i][0].toDouble();
                  maxStrength = swpc[i][1].toDouble();
                  break;
                } else if (selectedMaterial == "SUS304-WPB") {
                  minStrength = sus304[i][0].toDouble();
                  maxStrength = sus304[i][1].toDouble();
                  break;
                } else if (selectedMaterial == "C5191W-H") {
                  minStrength = c5191w[i][0].toDouble();
                  maxStrength = c5191w[i][1].toDouble();
                  break;
                }
              }
            }
            tensileStrength = minStrength.toInt().toString() +
                "~" +
                maxStrength.toInt().toString();
            forceA = coefficient * (freeLength! - selectedLengthA!);
            double k = ((4 * ratio - 1) / (4 * ratio - 4)) + (0.615 / ratio);
            strengthA = 8 *
                (wireDiameter! + coilInnerDiameter!) *
                forceA *
                k /
                (pi * pow(wireDiameter!, 3));
            forceB = coefficient * (freeLength! - selectedLengthB!);
            strengthB = 8 *
                (wireDiameter! + coilInnerDiameter!) *
                forceB *
                k /
                (pi * pow(wireDiameter!, 3));
            double minStrengthFactor = strengthA / (minStrength * 9.80665);
            double maxStrengthFactor = strengthB / (maxStrength * 9.80665);
            late int life;
            for (var i = (goodman.length - 1); i >= 0; i--) {
              double y = goodman[i][1] * minStrengthFactor + goodman[i][2];
              if (maxStrengthFactor > 0.67) {
                life = -1;
                break;
              } else if (y >= maxStrengthFactor) {
                life = goodman[i][0].toInt();
                break;
              } else if (i == 0) {
                life = 0;
              }
            }
            if (life > 0) {
              lifeTime = life;
            } else if (life == 0) {
              lifeTime = 1;
            } else if (life == -1) {
              lifeTime = 0;
            }

            return Column(
              // late double minLength, angle, ratio, coefficient, forceA, forceB, strengthA, strengthB, lifeTime, minStrength, maxStrength;
              // late String tensileStrength;
              children: [
                Text("밀착 길이: " + minLength.toString() + " mm"),
                SizedBox(height: 10),
                Text("부앙각: " + angle.toStringAsFixed(1) + " 도"),
                if (angle > 10)
                  Text(
                    "부앙각이 너무 큽니다! 10도 이하로 맞추세요.",
                    style: TextStyle(color: Colors.warningPrimaryColor),
                  ),
                SizedBox(height: 10),
                Text("스프링 지수: " + ratio.toStringAsFixed(1)),
                if (ratio <= 5 || ratio >= 25)
                  Text(
                    "스프링 지수가 범위를 벗어났습니다!\n선경을 줄이거나 코일 내경을 늘려 5~25 수준으로 조정하세요.",
                    style: TextStyle(
                      color: Colors.warningPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                SizedBox(height: 10),
                Text("스프링 상수: " + coefficient.toStringAsFixed(3)),
                SizedBox(height: 10),
                Text("인장 강도: " + tensileStrength + " kgf/mm^2"),
                SizedBox(height: 10),
                Text("지정 길이 A에서 하중: " + forceA.toStringAsFixed(2) + " N"),
                SizedBox(height: 10),
                Text("지정 길이 A에서 응력: " + strengthA.toStringAsFixed(2) + " N"),
                if (strengthA > (minStrength * 0.5 * 9.80665))
                  Text(
                    "인장 강도 하한선의 50% 수준을 넘습니다!",
                    style: TextStyle(color: Colors.warningPrimaryColor),
                  ),
                SizedBox(height: 10),
                Text("지정 길이 B에서 하중: " + forceB.toStringAsFixed(2) + " N"),
                SizedBox(height: 10),
                Text("지정 길이 B에서 응력: " + strengthB.toStringAsFixed(2) + " N"),
                if (strengthB > (minStrength * 0.5 * 9.80665))
                  Text(
                    "인장 강도 하한선의 50% 수준을 넘습니다!",
                    style: TextStyle(color: Colors.warningPrimaryColor),
                  ),
                SizedBox(height: 10),
                Text("반복 하중 시 예상 수명: " + lifeTime.toString() + " 만 회 이상"),
                if (lifeTime == 0)
                  Text(
                    "낮은 수명으로 문제가 있습니다!",
                    style: TextStyle(color: Colors.warningPrimaryColor),
                  ),
              ],
            );
          }
        }(),
      ),
    );
  }
}
