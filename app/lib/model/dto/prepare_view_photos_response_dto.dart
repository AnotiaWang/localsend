import 'package:dart_mappable/dart_mappable.dart';

part 'prepare_view_photos_response_dto.mapper.dart';

@MappableClass()
class PrepareViewPhotosResponseDto with PrepareViewPhotosResponseDtoMappable {
  final String sessionId;

  const PrepareViewPhotosResponseDto({
    required this.sessionId,
  });

  static const fromJson = PrepareViewPhotosResponseDtoMapper.fromJson;
}
