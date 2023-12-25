import 'package:dart_mappable/dart_mappable.dart';
import 'package:localsend_app/model/dto/info_register_dto.dart';

part 'prepare_view_photos_request_dto.mapper.dart';

@MappableClass()
class PrepareViewPhotosRequestDto with PrepareViewPhotosRequestDtoMappable {
  final InfoRegisterDto info;

  const PrepareViewPhotosRequestDto({required this.info});

  static const fromJson = PrepareViewPhotosRequestDtoMapper.fromJson;
}
