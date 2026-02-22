import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_color_provider.dart';
import '../../theme/theme.dart';
import 'widget/theme_color_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeColorNotifier colorNotifier = context.watch<ThemeColorNotifier>();

    return Container(
      color: colorNotifier.currentThemeColor.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text(
            "Settings",
            style: AppTextStyles.heading.copyWith(
              color: colorNotifier.currentThemeColor.color,
            ),
          ),

          SizedBox(height: 50),

          Text(
            "Theme",
            style: AppTextStyles.label.copyWith(color: AppColors.textLight),
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ThemeColor.values
                .map(
                  (theme) => ThemeColorButton(
                    themeColor: theme,
                    isSelected: theme == colorNotifier.currentThemeColor,
                    onTap: (value) {
                      colorNotifier.currentThemeColor = value;
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
