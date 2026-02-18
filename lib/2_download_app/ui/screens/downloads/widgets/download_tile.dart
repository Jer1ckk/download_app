import 'package:download_app/2_download_app/ui/theme/theme.dart';
import 'package:flutter/material.dart';

import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  DownloadStatus get status => controller.status;

  IconData getStatusIcon(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.notDownloaded:
        return Icons.download;
      case DownloadStatus.downloading:
        return Icons.downloading;
      case DownloadStatus.downloaded:
        return Icons.folder;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) {
        final subtitleText =
            status == DownloadStatus.downloading ||
                status == DownloadStatus.downloaded
            ? "${(controller.progress * 100).round()} % completed - ${(controller.ressource.size * controller.progress).round()} of ${controller.ressource.size} MB"
            : null;
        return Padding(
          padding: EdgeInsets.all(12),
          child: Container(
            height: 75,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(controller.ressource.name),
              subtitle: subtitleText != null ? Text(subtitleText, style: TextStyle(color: AppColors.neutral),) : null,
              trailing: GestureDetector(
                onTap: () {
                  if (status == DownloadStatus.notDownloaded) {
                    controller.startDownload();
                  }
                },
                child: Icon(getStatusIcon(status)),
              ),
            ),
          ),
        );
      },
    );
  }
}
