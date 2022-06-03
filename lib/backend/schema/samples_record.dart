import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'samples_record.g.dart';

abstract class SamplesRecord
    implements Built<SamplesRecord, SamplesRecordBuilder> {
  static Serializer<SamplesRecord> get serializer => _$samplesRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'sample_name')
  String get sampleName;

  @nullable
  String get deskripsi;

  @nullable
  String get bersedia;

  @nullable
  @BuiltValueField(wireName: 'image_url')
  String get imageUrl;

  @nullable
  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @nullable
  DocumentReference get user;

  @nullable
  @BuiltValueField(wireName: 'like_by')
  BuiltList<DocumentReference> get likeBy;

  @nullable
  String get jumlah;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(SamplesRecordBuilder builder) => builder
    ..sampleName = ''
    ..deskripsi = ''
    ..bersedia = ''
    ..imageUrl = ''
    ..likeBy = ListBuilder()
    ..jumlah = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('samples');

  static Stream<SamplesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<SamplesRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  SamplesRecord._();
  factory SamplesRecord([void Function(SamplesRecordBuilder) updates]) =
      _$SamplesRecord;

  static SamplesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createSamplesRecordData({
  String sampleName,
  String deskripsi,
  String bersedia,
  String imageUrl,
  DateTime createdAt,
  DocumentReference user,
  String jumlah,
}) =>
    serializers.toFirestore(
        SamplesRecord.serializer,
        SamplesRecord((s) => s
          ..sampleName = sampleName
          ..deskripsi = deskripsi
          ..bersedia = bersedia
          ..imageUrl = imageUrl
          ..createdAt = createdAt
          ..user = user
          ..likeBy = null
          ..jumlah = jumlah));
