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
        return Padding(
          padding: EdgeInsets.all(12),
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.ressource.name),
                      status != DownloadStatus.notDownloaded
                          ? Text(
                              "${(controller.progress * 100).round()} % completed - ${(controller.ressource.size * controller.progress).round()} of ${controller.ressource.size} MB",
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      if (status == DownloadStatus.notDownloaded) {
                        controller.startDownload();
                      }
                    },
                    icon: Icon(getStatusIcon(status)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
