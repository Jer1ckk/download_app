import 'package:download_app/2_download_app/main.dart';
import 'package:flutter/material.dart';

import '../../providers/theme_color_provider.dart';
import '../../theme/theme.dart';
import 'widget/theme_color_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeColorController,
      builder: (BuildContext context, Widget? child) {
        return Container(
          color: themeColorController.currentThemeColor.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text(
                "Settings",
                style: AppTextStyles.heading.copyWith(
                  color: themeColorController.currentThemeColor.color,
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
                        isSelected:
                            theme == themeColorController.currentThemeColor,
                        onTap: (value) {
                          themeColorController.currentThemeColor = value;
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
