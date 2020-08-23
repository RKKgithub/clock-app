import 'package:flutter/material.dart';
import 'screens/alarm_screen.dart';
import 'screens/stopwatch_screen.dart';
import 'screens/timer_screen.dart';
import 'screens/clock_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: StatefulHome(),
    );
  }
}

class StatefulHome extends StatefulWidget {
  @override
  _StatefulHomeState createState() => _StatefulHomeState();
}

class _StatefulHomeState extends State<StatefulHome> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    ClockScreen(),
    AlarmScreen(),
    StopwatchScreen(),
    TimerScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey,
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.query_builder),
              title: Text('Clock'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.alarm),
              title: Text('Alarm'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              title: Text('Stopwatch'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.av_timer),
              title: Text('Timer'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.greenAccent,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
