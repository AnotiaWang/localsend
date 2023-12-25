import 'package:logging/logging.dart';
import 'package:open_filex/open_filex.dart';

final _logger = Logger('OpenFolder');

/// Retrieves an image from the device's gallery at the specific path.
Future<void> openGalleryImage(String path) async {
  final asset = await PhotoManager.getAssetFromGallery(path: path);
  final file = await asset.file;
  OpenFilex.open(file.path);
  _logger.info('Open gallery image result: success, path: ${file.path}');
}
