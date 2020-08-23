import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:audioplayers/audioplayers.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  SharedPreferences prefs;

  String selectedTone = '1';

  AudioPlayer demoAdvancedPlayer = AudioPlayer();

  DropdownButton<String> androidDropdown() {
    AudioCache demoPlayer = AudioCache(fixedPlayer: demoAdvancedPlayer);
    List<DropdownMenuItem<String>> dropdownItems = [
      DropdownMenuItem(
        child: Text('1'),
        value: '1',
      ),
      DropdownMenuItem(
        child: Text('2'),
        value: '2',
      ),
      DropdownMenuItem(
        child: Text('3'),
        value: '3',
      ),
    ];

    return DropdownButton<String>(
      value: selectedTone,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedTone = value;
          demoAdvancedPlayer.stop();
          demoPlayer.play('$selectedTone.wav');
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    AudioCache demoPlayer = AudioCache(fixedPlayer: demoAdvancedPlayer);
    List<Text> pickerItems = [
      Text('1'),
      Text('2'),
      Text('3'),
    ];

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedTone = selectedIndex.toString();
          demoAdvancedPlayer.stop();
          demoPlayer.play('$selectedTone.wav');
        });
      },
      children: pickerItems,
    );
  }

  DateTime now = DateTime.now();
  DateTime alarmDateTime;
  DateTime nowAlarmCheck;

  String alarmHours = '00';
  String alarmMinutes = '00';

  bool isOn = false;

  int hourTime = 0;
  int minuteTime = 0;

  String audiofile = '1';

  AudioPlayer advancedPlayer = AudioPlayer();

  List<bool> repeat = [false, false, false, false, false, false, false];

  Map<int, String> days = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday'
  };

  bool isOnRebuild = true;

  bool playSound = true;
  bool rebuild = true;

  bool dismissButton = false;

  bool alert = false;

  void saveTime() async {
    prefs.setInt('hourTime', hourTime);
    prefs.setInt('minuteTime', minuteTime);
  }

  Future<int> getHourTime() async {
    return prefs.getInt('hourTime');
  }

  Future<int> getMinuteTime() async {
    return prefs.getInt('minuteTime');
  }

  void removeTime() async {
    prefs.remove('hourTime');
    prefs.remove('minuteTime');
  }

  void setTime() async {
    hourTime = await getHourTime();
    minuteTime = await getMinuteTime();
  }

  void createPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void saveIsOn({String key, bool value}) async {
    prefs.setBool(key, value);
  }

  Future<bool> getIsOn({String key}) async {
    return prefs.getBool(key);
  }

  void removeIson({String key}) async {
    prefs.remove(key);
  }

  bool stay = true;

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      setState(() {
        now = DateTime.now();
      });
    });

    createPrefs();

    if (prefs.getBool('isOnOnce') != null) {
      setState(() {
        isOn = true;
      });
    }

    if (prefs.getBool('repeatMon') != null && isOnRebuild == true) {
      setState(() {
        repeat[0] = true;
      });
      if (now.weekday == 1) {
        setState(() {
          alarmDateTime = DateFormat("EEEE HH:mm").parse(
              "Monday ${prefs.getInt('hourTime').toString().padLeft(2, '0')}:${prefs.getInt('minuteTime').toString().padLeft(2, '0')}");
          isOn = true;
          setTime();
          isOnRebuild == false;
        });
      }
    }

    if (prefs.getBool('repeatTue') != null && isOnRebuild == true) {
      setState(() {
        repeat[1] = true;
      });
      if (now.weekday == 2) {
        setState(() {
          alarmDateTime = DateFormat("EEEE HH:mm").parse(
              "Tuesday ${prefs.getInt('hourTime').toString().padLeft(2, '0')}:${prefs.getInt('minuteTime').toString().padLeft(2, '0')}");
          isOn = true;
          setTime();
          isOnRebuild == false;
        });
      }
    }

    if (prefs.getBool('repeatWed') != null && isOnRebuild == true) {
      setState(() {
        repeat[2] = true;
      });
      if (now.weekday == 3) {
        setState(() {
          alarmDateTime = DateFormat("EEEE HH:mm").parse(
              "Wednesday ${prefs.getInt('hourTime').toString().padLeft(2, '0')}:${prefs.getInt('minuteTime').toString().padLeft(2, '0')}");
          isOn = true;
          setTime();
          isOnRebuild == false;
        });
      }
    }

    if (prefs.getBool('repeatThu') != null && isOnRebuild == true) {
      setState(() {
        repeat[3] = true;
      });
      if (now.weekday == 4) {
        setState(() {
          alarmDateTime = DateFormat("EEEE HH:mm").parse(
              "Thursday ${prefs.getInt('hourTime').toString().padLeft(2, '0')}:${prefs.getInt('minuteTime').toString().padLeft(2, '0')}");
          isOn = true;
          setTime();
          isOnRebuild == false;
        });
      }
    }

    if (prefs.getBool('repeatFri') != null && isOnRebuild == true) {
      setState(() {
        repeat[4] = true;
      });
      if (now.weekday == 5) {
        setState(() {
          alarmDateTime = DateFormat("EEEE HH:mm").parse(
              "Friday ${prefs.getInt('hourTime').toString().padLeft(2, '0')}:${prefs.getInt('minuteTime').toString().padLeft(2, '0')}");
          isOn = true;
          setTime();
          isOnRebuild == false;
        });
      }
    }
    if (prefs.getBool('repeatSat') != null && isOnRebuild == true) {
      setState(() {
        repeat[5] = true;
      });
      if (now.weekday == 6) {
        setState(() {
          alarmDateTime = DateFormat("EEEE HH:mm").parse(
              "Saturday ${prefs.getInt('hourTime').toString().padLeft(2, '0')}:${prefs.getInt('minuteTime').toString().padLeft(2, '0')}");
          isOn = true;
          setTime();
          isOnRebuild == false;
        });
      }
    }

    if (prefs.getBool('repeatSun') != null && isOnRebuild == true) {
      setState(() {
        repeat[6] = true;
      });
      if (now.weekday == 7) {
        setState(() {
          alarmDateTime = DateFormat("EEEE HH:mm").parse(
              "Sunday ${prefs.getInt('hourTime').toString().padLeft(2, '0')}:${prefs.getInt('minuteTime').toString().padLeft(2, '0')}");
          isOn = true;
          setTime();
          isOnRebuild == false;
        });
      }
    }

    String hour = now.hour.toString().padLeft(2, '0');
    String minute = now.minute.toString().padLeft(2, '0');

    nowAlarmCheck =
        DateFormat("EEEE HH:mm").parse('${days[now.weekday]} $hour:$minute');

    if (alarmDateTime == nowAlarmCheck && isOn == true && rebuild == true) {
      final player = AudioCache(fixedPlayer: advancedPlayer);
      setState(() {
        dismissButton = true;
        rebuild = false;
        prefs.remove('isOnOnce');
      });
      player.loop('$selectedTone.wav');
    }

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  color: (isOn == true) ? Colors.orange : Colors.black,
                  elevation: 20,
                  child: SwitchListTile(
                    secondary: Icon(Icons.alarm),
                    title: Text(
                      '${hourTime.toString().padLeft(2, '0')}:${minuteTime.toString().padLeft(2, '0')}',
                      style: GoogleFonts.sansita(),
                    ),
                    value: isOn,
                    onChanged: (value) {
                      if (value == false) {
                        prefs.remove('isOn');
                        prefs.remove('repeatMon');
                        prefs.remove('repeatTue');
                        prefs.remove('repeatWed');
                        prefs.remove('repeatThu');
                        prefs.remove('repeatFri');
                        prefs.remove('repeatSat');
                        prefs.remove('repeatSun');
                        prefs.remove('hourTime');
                        prefs.remove('minuteTime');
                        prefs.remove('isOnOnce');

                        for (int i = 0; i < repeat.length; i++) {
                          setState(() {
                            repeat[i] = false;
                          });
                        }
                      }
                      setState(() {
                        rebuild = true;
                        alarmDateTime = DateFormat("EEEE HH:mm").parse(
                            "${days[now.weekday]} $alarmHours:$alarmMinutes");
                        isOn = value;
                        if (isOn) {
                          for (int i = 0; i < repeat.length; i++) {
                            if (repeat[i] == false) {
                              saveIsOn(key: 'isOnOnce', value: isOn);
                            }
                          }
                        } else {
                          prefs.remove('isOnOnce');
                        }
                      });
                    },
                  ),
                ),
                Card(
                  elevation: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            'Set Alarm Time',
                            style: GoogleFonts.didactGothic(fontSize: 20)
                                .copyWith(color: Colors.black),
                          ),
                          Divider(
                            color: Colors.blue,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Hours',
                                    style: GoogleFonts.imFellGreatPrimerSc(
                                            fontSize: 10)
                                        .copyWith(color: Colors.greenAccent),
                                  ),
                                  NumberPicker.integer(
                                      initialValue: hourTime,
                                      minValue: 0,
                                      maxValue: 23,
                                      onChanged: (value) {
                                        prefs.remove('isOn');
                                        prefs.remove('repeatMon');
                                        prefs.remove('repeatTue');
                                        prefs.remove('repeatWed');
                                        prefs.remove('repeatThu');
                                        prefs.remove('repeatFri');
                                        prefs.remove('repeatSat');
                                        prefs.remove('repeatSun');
                                        prefs.remove('hourTime');
                                        prefs.remove('minuteTime');
                                        prefs.remove('isOnOnce');

                                        for (int i = 0;
                                            i < repeat.length;
                                            i++) {
                                          setState(() {
                                            repeat[i] = false;
                                          });
                                        }
                                        setState(() {
                                          isOn = false;
                                          alarmHours =
                                              value.toString().padLeft(2, '0');
                                          hourTime = value;
                                        });
                                      }),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Minutes',
                                    style: GoogleFonts.imFellGreatPrimerSc(
                                            fontSize: 10)
                                        .copyWith(color: Colors.greenAccent),
                                  ),
                                  NumberPicker.integer(
                                      initialValue: minuteTime,
                                      minValue: 0,
                                      maxValue: 59,
                                      onChanged: (value) {
                                        prefs.remove('isOn');
                                        prefs.remove('repeatMon');
                                        prefs.remove('repeatTue');
                                        prefs.remove('repeatWed');
                                        prefs.remove('repeatThu');
                                        prefs.remove('repeatFri');
                                        prefs.remove('repeatSat');
                                        prefs.remove('repeatSun');
                                        prefs.remove('hourTime');
                                        prefs.remove('minuteTime');
                                        prefs.remove('isOnOnce');

                                        for (int i = 0;
                                            i < repeat.length;
                                            i++) {
                                          setState(() {
                                            repeat[i] = false;
                                          });
                                        }
                                        setState(() {
                                          isOn = false;
                                          alarmMinutes =
                                              value.toString().padLeft(2, '0');
                                          minuteTime = value;
                                        });
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      color: repeat[0] ? Colors.blue : Colors.white70,
                      shape: StadiumBorder(),
                      onPressed: () async {
                        repeat[0] = !repeat[0];
                        if (repeat[0] && isOn) {
                          saveIsOn(key: 'isOn', value: isOn);
                          saveIsOn(key: 'repeatMon', value: repeat[0]);
                          saveTime();
                        } else {
                          isOnRebuild = true;
                          removeIson(key: 'isOn');
                          removeIson(key: 'repeatMon');
                          removeTime();
                        }
                      },
                      child: Text('Mon'),
                    ),
                    RaisedButton(
                      color: repeat[1] ? Colors.blue : Colors.white70,
                      shape: StadiumBorder(),
                      onPressed: () async {
                        repeat[1] = !repeat[1];
                        if (repeat[1] && isOn) {
                          saveIsOn(key: 'isOn', value: isOn);
                          saveIsOn(key: 'repeatTue', value: repeat[1]);
                          saveTime();
                        } else {
                          isOnRebuild = true;
                          removeIson(key: 'isOn');
                          removeIson(key: 'repeatTue');
                          removeTime();
                        }
                      },
                      child: Text('Tue'),
                    ),
                    RaisedButton(
                      color: repeat[2] ? Colors.blue : Colors.white70,
                      shape: StadiumBorder(),
                      onPressed: () async {
                        repeat[2] = !repeat[2];
                        if (repeat[2] && isOn) {
                          saveIsOn(key: 'isOn', value: isOn);
                          saveIsOn(key: 'repeatWed', value: repeat[2]);
                          saveTime();
                        } else {
                          isOnRebuild = true;
                          removeIson(key: 'isOn');
                          removeIson(key: 'repeatWed');
                          removeTime();
                        }
                      },
                      child: Text('Wed'),
                    ),
                    RaisedButton(
                      color: repeat[3] ? Colors.blue : Colors.white70,
                      shape: StadiumBorder(),
                      onPressed: () async {
                        repeat[3] = !repeat[3];
                        if (repeat[3] && isOn) {
                          saveIsOn(key: 'isOn', value: isOn);
                          saveIsOn(key: 'repeatThu', value: repeat[3]);
                          saveTime();
                        } else {
                          isOnRebuild = true;
                          removeIson(key: 'isOn');
                          removeIson(key: 'repeatThu');
                          removeTime();
                        }
                      },
                      child: Text('Thu'),
                    ),
                    RaisedButton(
                      color: repeat[4] ? Colors.blue : Colors.white70,
                      shape: StadiumBorder(),
                      onPressed: () async {
                        repeat[4] = !repeat[4];
                        if (repeat[4] && isOn) {
                          saveIsOn(key: 'isOn', value: isOn);
                          saveIsOn(key: 'repeatFri', value: repeat[4]);
                          saveTime();
                        } else {
                          isOnRebuild = true;
                          removeIson(key: 'isOn');
                          removeIson(key: 'repeatFri');
                          removeTime();
                        }
                      },
                      child: Text('Fri'),
                    ),
                    RaisedButton(
                      color: repeat[5] ? Colors.blue : Colors.white70,
                      shape: StadiumBorder(),
                      onPressed: () async {
                        repeat[5] = !repeat[5];
                        if (repeat[5] && isOn) {
                          saveIsOn(key: 'isOn', value: isOn);
                          saveIsOn(key: 'repeatSat', value: repeat[5]);
                          saveTime();
                        } else {
                          isOnRebuild = true;
                          removeIson(key: 'isOn');
                          removeIson(key: 'repeatSat');
                          removeTime();
                        }
                      },
                      child: Text('Sat'),
                    ),
                    RaisedButton(
                      color: repeat[6] ? Colors.blue : Colors.white70,
                      shape: StadiumBorder(),
                      onPressed: () async {
                        repeat[6] = !repeat[6];
                        if (repeat[6] && isOn) {
                          saveIsOn(key: 'isOn', value: isOn);
                          saveIsOn(key: 'repeatSun', value: repeat[6]);
                          saveTime();
                        } else {
                          isOnRebuild = true;
                          removeIson(key: 'isOn');
                          removeIson(key: 'repeatSun');
                          removeTime();
                        }
                      },
                      child: Text('Sun'),
                    ),
                  ],
                ),
                (!dismissButton)
                    ? Column(
                        children: [
                          Text(
                            'Alarm Tone',
                            style: GoogleFonts.mina()
                                .copyWith(color: Colors.greenAccent),
                          ),
                          (Platform.isIOS ? iOSPicker() : androidDropdown())
                        ],
                      )
                    : RaisedButton(
                        onPressed: () {
                          Alert(
                            context: context,
                            title: "ALARM!!ANSWER QUESTION!!",
                            desc:
                                "How much did Microsoft aquire LinkedIn for??",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "20.7B USD",
                                  style: GoogleFonts.didactGothic()
                                      .copyWith(color: Colors.red),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                              DialogButton(
                                child: Text(
                                  "26.2B USD",
                                  style: GoogleFonts.didactGothic()
                                      .copyWith(color: Colors.red),
                                ),
                                onPressed: () {
                                  setState(() {
                                    advancedPlayer.stop();
                                    dismissButton = false;
                                    isOn = false;
                                  });
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ).show();
                        },
                        child: Text('Dismiss'),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
