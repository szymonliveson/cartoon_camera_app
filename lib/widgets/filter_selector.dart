import 'package:flutter/material.dart';

class FilterSelector extends StatelessWidget {
  final List<String> styles;
  final String selectedStyle;
  final Function(String) onStyleSelected;

  FilterSelector({required this.styles, required this.selectedStyle, required this.onStyleSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: styles.map((style) {
        return GestureDetector(
          onTap: () => onStyleSelected(style),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: selectedStyle == style ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              style,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}