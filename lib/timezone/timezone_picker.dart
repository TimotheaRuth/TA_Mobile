import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
import 'dart:async';

class TimezonePicker extends StatefulWidget {
  @override
  _TimezonePickerState createState() => _TimezonePickerState();
}

class _TimezonePickerState extends State<TimezonePicker> {
  final TimezoneService _timezoneService = TimezoneService();
  List<String> _timezones = ['Asia/Jakarta', 'Asia/Makassar', 'Asia/Jayapura'];
  String? _selectedTimezone;
  tz.TZDateTime? _currentTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _selectedTimezone = _timezones[0]; // Set default timezone
    _updateTime();
  }

  void _updateTime() {
    final location = tz.getLocation(_selectedTimezone!);
    setState(() {
      _currentTime = tz.TZDateTime.now(location);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Timezone Picker')),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _selectedTimezone,
            items: _timezones.map((timezone) {
              return DropdownMenuItem<String>(
                value: timezone,
                child: Text(timezone),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedTimezone = value;
                _updateTime();
                _timer?.cancel();
                _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
              });
            },
          ),
          if (_currentTime != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Current time: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(_currentTime!)}',
                style: TextStyle(fontSize: 24),
              ),
            ),
        ],
      ),
    );
  }
}

class TimezoneService {

}
