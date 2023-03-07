import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  var result = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2022, 1, 1), // the earliest allowable
                    lastDate: DateTime(2030, 12, 31), // the latest allowable
                    currentDate: startDate,

                    saveText: 'Done',
                  );
                  if (result != null) {
                    setState(() {
                      startDate = result.start;
                      endDate = result.end;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  elevation: 5,
                ),
                icon: const Icon(MdiIcons.calendarBlank),
                label: Text(
                  "Start: ${startDate.day}/${startDate.month}/${startDate.year}",
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  var result = await showDateRangePicker(
                    builder: ((context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          appBarTheme: AppBarTheme().copyWith(
                              // color: Colors.black,
                              ),
                          colorScheme: const ColorScheme.light(
                            primary: Colors.blue,
                            surface: Colors.blue,
                          ),
                          dialogBackgroundColor: Colors.blue,
                        ),
                        child: child as Widget,
                      );
                    }),
                    context: context,
                    firstDate: DateTime(2022, 1, 1), // the earliest allowable
                    lastDate: DateTime(2030, 12, 31), // the latest allowable
                    currentDate: endDate,

                    saveText: 'Done',
                  );
                  if (result != null) {
                    setState(() {
                      startDate = result.start;
                      endDate = result.end;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  elevation: 5,
                ),
                icon: const Icon(MdiIcons.calendarBlank),
                label: Text(
                  "End: ${endDate.day}/${endDate.month}/${endDate.year}",
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class MyTableCalendar extends StatefulWidget {
  @override
  State<MyTableCalendar> createState() => _MyTableCalendarState();
}

class _MyTableCalendarState extends State<MyTableCalendar> {
  late DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarFormat: _calendarFormat,
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      // onPageChanged: (focusedDay) {
      //   setState(() {
      //     _focusedDay = focusedDay;
      //   });
      // },
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _selectedDay,
    );
  }
}
