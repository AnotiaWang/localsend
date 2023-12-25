// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'prepare_view_photos_request_dto.dart';

class PrepareViewPhotosRequestDtoMapper
    extends ClassMapperBase<PrepareViewPhotosRequestDto> {
  PrepareViewPhotosRequestDtoMapper._();

  static PrepareViewPhotosRequestDtoMapper? _instance;
  static PrepareViewPhotosRequestDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = PrepareViewPhotosRequestDtoMapper._());
      InfoRegisterDtoMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'PrepareViewPhotosRequestDto';

  static InfoRegisterDto _$info(PrepareViewPhotosRequestDto v) => v.info;
  static const Field<PrepareViewPhotosRequestDto, InfoRegisterDto> _f$info =
      Field('info', _$info);

  @override
  final Map<Symbol, Field<PrepareViewPhotosRequestDto, dynamic>> fields =
      const {
    #info: _f$info,
  };

  static PrepareViewPhotosRequestDto _instantiate(DecodingData data) {
    return PrepareViewPhotosRequestDto(info: data.dec(_f$info));
  }

  @override
  final Function instantiate = _instantiate;

  static PrepareViewPhotosRequestDto fromJson(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<PrepareViewPhotosRequestDto>(map));
  }

  static PrepareViewPhotosRequestDto deserialize(String json) {
    return _guard((c) => c.fromJson<PrepareViewPhotosRequestDto>(json));
  }
}

mixin PrepareViewPhotosRequestDtoMappable {
  String serialize() {
    return PrepareViewPhotosRequestDtoMapper._guard(
        (c) => c.toJson(this as PrepareViewPhotosRequestDto));
  }

  Map<String, dynamic> toJson() {
    return PrepareViewPhotosRequestDtoMapper._guard(
        (c) => c.toMap(this as PrepareViewPhotosRequestDto));
  }

  PrepareViewPhotosRequestDtoCopyWith<PrepareViewPhotosRequestDto,
          PrepareViewPhotosRequestDto, PrepareViewPhotosRequestDto>
      get copyWith => _PrepareViewPhotosRequestDtoCopyWithImpl(
          this as PrepareViewPhotosRequestDto, $identity, $identity);
  @override
  String toString() {
    return PrepareViewPhotosRequestDtoMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            PrepareViewPhotosRequestDtoMapper._guard(
                (c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return PrepareViewPhotosRequestDtoMapper._guard((c) => c.hash(this));
  }
}

extension PrepareViewPhotosRequestDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PrepareViewPhotosRequestDto, $Out> {
  PrepareViewPhotosRequestDtoCopyWith<$R, PrepareViewPhotosRequestDto, $Out>
      get $asPrepareViewPhotosRequestDto => $base
          .as((v, t, t2) => _PrepareViewPhotosRequestDtoCopyWithImpl(v, t, t2));
}

abstract class PrepareViewPhotosRequestDtoCopyWith<
    $R,
    $In extends PrepareViewPhotosRequestDto,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  InfoRegisterDtoCopyWith<$R, InfoRegisterDto, InfoRegisterDto> get info;
  $R call({InfoRegisterDto? info});
  PrepareViewPhotosRequestDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PrepareViewPhotosRequestDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PrepareViewPhotosRequestDto, $Out>
    implements
        PrepareViewPhotosRequestDtoCopyWith<$R, PrepareViewPhotosRequestDto,
            $Out> {
  _PrepareViewPhotosRequestDtoCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PrepareViewPhotosRequestDto> $mapper =
      PrepareViewPhotosRequestDtoMapper.ensureInitialized();
  @override
  InfoRegisterDtoCopyWith<$R, InfoRegisterDto, InfoRegisterDto> get info =>
      $value.info.copyWith.$chain((v) => call(info: v));
  @override
  $R call({InfoRegisterDto? info}) =>
      $apply(FieldCopyWithData({if (info != null) #info: info}));
  @override
  PrepareViewPhotosRequestDto $make(CopyWithData data) =>
      PrepareViewPhotosRequestDto(info: data.get(#info, or: $value.info));

  @override
  PrepareViewPhotosRequestDtoCopyWith<$R2, PrepareViewPhotosRequestDto, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PrepareViewPhotosRequestDtoCopyWithImpl($value, $cast, t);
}
