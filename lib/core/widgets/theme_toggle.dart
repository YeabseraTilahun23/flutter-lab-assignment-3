import 'package:flutter/material.dart';

class ThemeToggleSwitch extends StatefulWidget {
  final Function(ThemeMode) onThemeChanged;

  const ThemeToggleSwitch({super.key, required this.onThemeChanged});

  @override
  State<ThemeToggleSwitch> createState() => _ThemeToggleSwitchState();
}

class _ThemeToggleSwitchState extends State<ThemeToggleSwitch> {
  ThemeMode _mode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ThemeMode>(
      icon: const Icon(Icons.color_lens),
      onSelected: (mode) {
        setState(() => _mode = mode);
        widget.onThemeChanged(mode);
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: ThemeMode.system,
          child: Text('System Default'),
        ),
        const PopupMenuItem(
          value: ThemeMode.light,
          child: Text('Light Theme'),
        ),
        const PopupMenuItem(
          value: ThemeMode.dark,
          child: Text('Dark Theme'),
        ),
      ],
    );
  }
}
