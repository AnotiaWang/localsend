import 'package:logging/logging.dart';
import 'package:open_filex/open_filex.dart';

final _logger = Logger('OpenFolder');

/// Retrieves an image from the device's gallery at the specific path.
Future<void> openGalleryImage(String path) async {
  final List<AssetEntity> assets = await PhotoManager.getAssetPathList(type: RequestType.image);
  final AssetEntity asset = assets.first;
  final File? file = await asset.file;
  OpenFilex.open(file.path);
  _logger.info('Open gallery image result: success, path: ${file.path}');
}
