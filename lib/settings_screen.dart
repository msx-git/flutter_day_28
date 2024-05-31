import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_day_28/constants/app_constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
    required this.onTextSizeChanged,
    required this.onBackgroundChanged,
    required this.onTextColorChanged,
  });

  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<double> onTextSizeChanged;
  final ValueChanged<String> onBackgroundChanged;
  final ValueChanged<Color> onTextColorChanged;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final textSizeController = TextEditingController();
  final backgroundController = TextEditingController();
  Color textColor = AppConstants.textColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(AppConstants.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SwitchListTile(
              title: Text(
                'Dark mode',
                style: TextStyle(
                    fontSize: AppConstants.textSize,
                    color: AppConstants.textColor),
              ),
              value: AppConstants.themeMode == ThemeMode.dark,
              onChanged: widget.onThemeChanged,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textSizeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Enter text size',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: () {
                      widget.onTextSizeChanged(
                        double.parse(textSizeController.text.trim()),
                      );
                    },
                    child: const Text("Set size"),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: backgroundController,
                      decoration: InputDecoration(
                        labelText: 'Enter image link',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: () {
                      widget.onBackgroundChanged(
                        backgroundController.text.trim(),
                      );
                    },
                    child: const Text("Change background"),
                  )
                ],
              ),
            ),
            Expanded(
              child: ColorPicker(
                pickerColor: textColor,
                onColorChanged: (value) {
                  textColor = value;
                  widget.onTextColorChanged(textColor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
