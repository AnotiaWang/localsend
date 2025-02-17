import 'package:flutter/material.dart';
import 'package:localsend_app/model/device.dart';
import 'package:localsend_app/util/ip_helper.dart';
import 'package:localsend_app/util/native/platform_check.dart';
import 'package:localsend_app/widget/custom_progress_bar.dart';
import 'package:localsend_app/widget/device_bage.dart';
import 'package:localsend_app/widget/list_tile/custom_list_tile.dart';

class DeviceListTile extends StatelessWidget {
  final Device device;
  final bool isFavorite;
  final String? info;
  final double? progress;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onViewPhotosTap;

  const DeviceListTile({
    required this.device,
    this.isFavorite = false,
    this.info,
    this.progress,
    this.onTap,
    this.onFavoriteTap,
    this.onViewPhotosTap,
  });

  @override
  Widget build(BuildContext context) {
    final badgeColor = Color.lerp(Theme.of(context).colorScheme.secondaryContainer, Colors.white, 0.3)!;
    return CustomListTile(
      icon: Icon(device.deviceType.icon, size: 46),
      title: Text(device.alias, style: const TextStyle(fontSize: 20)),
      trailing: Column(
        children: [
          if (onFavoriteTap != null)
            IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: onFavoriteTap,
              tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites', // TODO: translate
            ),
          if (device.deviceType == DeviceType.mobile && checkPlatformIsDesktop() && onViewPhotosTap != null)
            IconButton(
              icon: const Icon(Icons.image),
              onPressed: onViewPhotosTap,
              tooltip: 'View Photos', // TODO: translate
            ),
        ],
      ),
      subTitle: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: [
          if (info != null)
            Text(info!, style: const TextStyle(color: Colors.grey))
          else if (progress != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: CustomProgressBar(progress: progress!),
            )
          else ...[
            DeviceBadge(
              backgroundColor: badgeColor,
              foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
              label: '#${device.ip.visualId}',
            ),
            if (device.deviceModel != null)
              DeviceBadge(
                backgroundColor: badgeColor,
                foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                label: device.deviceModel!,
              ),
          ],
        ],
      ),
      onTap: onTap,
    );
  }
}
