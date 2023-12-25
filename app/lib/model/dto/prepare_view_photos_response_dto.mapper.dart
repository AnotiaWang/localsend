// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'prepare_view_photos_response_dto.dart';

class PrepareViewPhotosResponseDtoMapper
    extends ClassMapperBase<PrepareViewPhotosResponseDto> {
  PrepareViewPhotosResponseDtoMapper._();

  static PrepareViewPhotosResponseDtoMapper? _instance;
  static PrepareViewPhotosResponseDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = PrepareViewPhotosResponseDtoMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'PrepareViewPhotosResponseDto';

  static String _$sessionId(PrepareViewPhotosResponseDto v) => v.sessionId;
  static const Field<PrepareViewPhotosResponseDto, String> _f$sessionId =
      Field('sessionId', _$sessionId);

  @override
  final Map<Symbol, Field<PrepareViewPhotosResponseDto, dynamic>> fields =
      const {
    #sessionId: _f$sessionId,
  };

  static PrepareViewPhotosResponseDto _instantiate(DecodingData data) {
    return PrepareViewPhotosResponseDto(sessionId: data.dec(_f$sessionId));
  }

  @override
  final Function instantiate = _instantiate;

  static PrepareViewPhotosResponseDto fromJson(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<PrepareViewPhotosResponseDto>(map));
  }

  static PrepareViewPhotosResponseDto deserialize(String json) {
    return _guard((c) => c.fromJson<PrepareViewPhotosResponseDto>(json));
  }
}

mixin PrepareViewPhotosResponseDtoMappable {
  String serialize() {
    return PrepareViewPhotosResponseDtoMapper._guard(
        (c) => c.toJson(this as PrepareViewPhotosResponseDto));
  }

  Map<String, dynamic> toJson() {
    return PrepareViewPhotosResponseDtoMapper._guard(
        (c) => c.toMap(this as PrepareViewPhotosResponseDto));
  }

  PrepareViewPhotosResponseDtoCopyWith<PrepareViewPhotosResponseDto,
          PrepareViewPhotosResponseDto, PrepareViewPhotosResponseDto>
      get copyWith => _PrepareViewPhotosResponseDtoCopyWithImpl(
          this as PrepareViewPhotosResponseDto, $identity, $identity);
  @override
  String toString() {
    return PrepareViewPhotosResponseDtoMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            PrepareViewPhotosResponseDtoMapper._guard(
                (c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return PrepareViewPhotosResponseDtoMapper._guard((c) => c.hash(this));
  }
}

extension PrepareViewPhotosResponseDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PrepareViewPhotosResponseDto, $Out> {
  PrepareViewPhotosResponseDtoCopyWith<$R, PrepareViewPhotosResponseDto, $Out>
      get $asPrepareViewPhotosResponseDto => $base.as(
          (v, t, t2) => _PrepareViewPhotosResponseDtoCopyWithImpl(v, t, t2));
}

abstract class PrepareViewPhotosResponseDtoCopyWith<
    $R,
    $In extends PrepareViewPhotosResponseDto,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? sessionId});
  PrepareViewPhotosResponseDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PrepareViewPhotosResponseDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PrepareViewPhotosResponseDto, $Out>
    implements
        PrepareViewPhotosResponseDtoCopyWith<$R, PrepareViewPhotosResponseDto,
            $Out> {
  _PrepareViewPhotosResponseDtoCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PrepareViewPhotosResponseDto> $mapper =
      PrepareViewPhotosResponseDtoMapper.ensureInitialized();
  @override
  $R call({String? sessionId}) =>
      $apply(FieldCopyWithData({if (sessionId != null) #sessionId: sessionId}));
  @override
  PrepareViewPhotosResponseDto $make(CopyWithData data) =>
      PrepareViewPhotosResponseDto(
          sessionId: data.get(#sessionId, or: $value.sessionId));

  @override
  PrepareViewPhotosResponseDtoCopyWith<$R2, PrepareViewPhotosResponseDto, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PrepareViewPhotosResponseDtoCopyWithImpl($value, $cast, t);
}
