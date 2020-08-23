import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:audioplayers/audio_cache.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int selectedHours = 0;
  int selectedMinutes = 0;
  int selectedSeconds = 0;

  int totalTime;

  bool isStarted = false;
  bool isCancelled = false;

  void startTimer() {
    totalTime =
        selectedSeconds + (selectedMinutes * 60) + (selectedHours * 3600);
    setState(() {
      isStarted = true;
    });
  }

  Widget countDownTimer() {
    Widget timer;

    if (isStarted == true) {
      timer = Column(
        children: [
          CircularCountDownTimer(
            duration: totalTime,
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 4,
            color: Colors.white,
            fillColor: Colors.red,
            strokeWidth: 5.0,
            textStyle:
                GoogleFonts.robotoSlab().copyWith(color: Colors.greenAccent),
            isReverse: true,
            isTimerTextShown: true,
            onComplete: () {
              final player = AudioCache();
              player.play('1.wav');
              Future.delayed(
                Duration(seconds: 1),
                () => setState(() {
                  isStarted = false;
                }),
              );
            },
          ),
          FlatButton(
            child: Text('Cancel'),
            color: Colors.red,
            shape: StadiumBorder(),
            onPressed: () {
              setState(() {
                isStarted = false;
              });
            },
          )
        ],
      );
    } else {
      timer = Divider(
        color: Colors.amber,
      );
    }

    return timer;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Hours',
                              style: GoogleFonts.almendraSc()
                                  .copyWith(color: Colors.greenAccent),
                            ),
                            NumberPicker.integer(
                                initialValue: selectedHours,
                                minValue: 00,
                                maxValue: 23,
                                onChanged: (value) {
                                  setState(() {
                                    selectedHours = value;
                                  });
                                }),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Minutes',
                              style: GoogleFonts.almendraSc()
                                  .copyWith(color: Colors.greenAccent),
                            ),
                            NumberPicker.integer(
                                initialValue: selectedMinutes,
                                minValue: 00,
                                maxValue: 59,
                                onChanged: (value) {
                                  setState(() {
                                    selectedMinutes = value;
                                  });
                                }),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Seconds',
                              style: GoogleFonts.almendraSc()
                                  .copyWith(color: Colors.greenAccent),
                            ),
                            NumberPicker.integer(
                                initialValue: selectedSeconds,
                                minValue: 00,
                                maxValue: 59,
                                onChanged: (value) {
                                  setState(() {
                                    selectedSeconds = value;
                                  });
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              countDownTimer(),
              (isStarted == false)
                  ? FlatButton(
                      child: Text('Start'),
                      color: Colors.blue,
                      shape: StadiumBorder(),
                      onPressed: () {
                        startTimer();
                      },
                    )
                  : Divider(
                      color: Colors.amber,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
