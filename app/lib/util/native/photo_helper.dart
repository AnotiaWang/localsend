import 'package:photo_manager/photo_manager.dart';

Future<List<AssetEntity>> getAlbumPhotos() async {
  final permResult = await PhotoManager.requestPermissionExtend();
  if (!permResult.hasAccess) throw Exception('No permission');

  final albums = await PhotoManager.getAssetPathList(
    type: RequestType.image,
    hasAll: true,
    onlyAll: true,
  );
  final album = albums.first;
  final assets = await album.getAssetListRange(start: 0, end: 1000000);
  return assets.where((element) => element.type == AssetType.image).toList();
}
