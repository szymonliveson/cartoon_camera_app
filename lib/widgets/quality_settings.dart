import 'package:flutter/material.dart';

class QualitySettings extends StatefulWidget {
  @override
  _QualitySettingsState createState() => _QualitySettingsState();
}

class _QualitySettingsState extends State<QualitySettings> {
  double _pixelSize = 1.0;
  double _quality = 50.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Pixel Size: ${_pixelSize.toStringAsFixed(1)}'),
        Slider(
          value: _pixelSize,
          min: 0.0,
          max: 10.0,
          divisions: 100,
          label: _pixelSize.toStringAsFixed(1),
          onChanged: (double value) {
            setState(() {
              _pixelSize = value;
            });
          },
        ),
        Text('Quality: ${_quality.toStringAsFixed(0)}%'),
        Slider(
          value: _quality,
          min: 0.0,
          max: 100.0,
          divisions: 100,
          label: '${_quality.toStringAsFixed(0)}%',
          onChanged: (double value) {
            setState(() {
              _quality = value;
            });
          },
        ),
      ],
    );
  }
}