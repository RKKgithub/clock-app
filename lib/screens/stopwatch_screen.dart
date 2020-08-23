import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  bool isStarted = false;
  bool isStopped = false;

  Widget getButtons() {
    var buttons;

    if (isStarted == false && isStopped == false) {
      buttons = RaisedButton(
        padding: const EdgeInsets.all(4),
        color: Colors.blue,
        shape: StadiumBorder(),
        onPressed: () async {
          setState(() {
            isStarted = true;
          });
          _stopWatchTimer.onExecute.add(StopWatchExecute.start);
        },
        child: Text(
          'Start',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else if (isStarted == true && isStopped == false) {
      buttons = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton(
            padding: const EdgeInsets.all(4),
            color: Colors.red,
            shape: StadiumBorder(),
            onPressed: () async {
              setState(() {
                isStopped = true;
                isStarted = false;
              });
              _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
            },
            child: Text(
              'Stop',
              style: TextStyle(color: Colors.white),
            ),
          ),
          RaisedButton(
            padding: const EdgeInsets.all(4),
            color: Colors.green,
            shape: StadiumBorder(),
            onPressed: () async {
              _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
            },
            child: Text(
              'Lap',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    } else if (isStopped == true) {
      buttons = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton(
            padding: const EdgeInsets.all(4),
            color: Colors.blue,
            shape: StadiumBorder(),
            onPressed: () async {
              setState(() {
                isStarted = true;
                isStopped = false;
              });
              _stopWatchTimer.onExecute.add(StopWatchExecute.start);
            },
            child: Text(
              'Resume',
              style: TextStyle(color: Colors.white),
            ),
          ),
          RaisedButton(
            padding: const EdgeInsets.all(4),
            color: Colors.amber,
            shape: StadiumBorder(),
            onPressed: () async {
              setState(() {
                isStarted = false;
                isStopped = false;
              });
              _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
            },
            child: Text(
              'Reset',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    }

    return buttons;
  }

  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
  );

  final _scrollController = ScrollController();

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 20,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: StreamBuilder<int>(
                      stream: _stopWatchTimer.rawTime,
                      initialData: _stopWatchTimer.rawTime.value,
                      builder: (context, snap) {
                        final value = snap.data;
                        final displayTime = StopWatchTimer.getDisplayTime(value,
                            hours: _isHours);
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                displayTime,
                                style: GoogleFonts.marvel(fontSize: 40)
                                    .copyWith(color: Colors.greenAccent),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                height: 200,
                margin: const EdgeInsets.all(8),
                child: StreamBuilder<List<StopWatchRecord>>(
                  stream: _stopWatchTimer.records,
                  initialData: _stopWatchTimer.records.value,
                  builder: (context, snap) {
                    final value = snap.data;
                    if (value.isEmpty) {
                      return Container();
                    }
                    Future.delayed(Duration(milliseconds: 100), () {
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeOut);
                    });
                    return ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        final data = value[index];
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '${index + 1}: ${data.displayTime}',
                                style: GoogleFonts.marvel(fontSize: 17)
                                    .copyWith(color: Colors.greenAccent),
                              ),
                            ),
                            Divider(
                              color: Colors.amber,
                            )
                          ],
                        );
                      },
                      itemCount: value.length,
                    );
                  },
                ),
              ),
              getButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
