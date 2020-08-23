import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class ClockScreen extends StatefulWidget {
  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      setState(() {
        now = DateTime.now();
      });
    });

    String formattedTime = DateFormat.Hm().format(now);
    String formattedDate = DateFormat.yMMMMd('en_US').format(now);
    String timezoneString = now.timeZoneOffset.toString().split('.').first;
    String offsetSign = '';
    if (!timezoneString.startsWith('-')) {
      offsetSign = '+';
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
            child: Card(
              child: Container(
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formattedTime,
                      style: GoogleFonts.armata(fontSize: 70)
                          .copyWith(color: Colors.greenAccent),
                    ),
                    Text(
                      '24 hour format',
                      style: GoogleFonts.acme().copyWith(color: Colors.blue),
                    ),
                    Text(
                      'UTC $offsetSign $timezoneString',
                      style: GoogleFonts.alike().copyWith(color: Colors.blue),
                    ),
                    Text(
                      'Indian Standard Time',
                      style: GoogleFonts.alike().copyWith(color: Colors.blue),
                    ),
                    Text(
                      formattedDate,
                      style: GoogleFonts.aBeeZee(fontSize: 30)
                          .copyWith(color: Colors.greenAccent),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
